# -*- encoding: utf-8 -*-
module EnjuNdl
  module NdlSearch
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def import_isbn(isbn)
        manifestation = Manifestation.import_from_ndl_search(:isbn => isbn)
        manifestation
      end

      def import_from_ndl_search(options)
        #if options[:isbn]
          lisbn = Lisbn.new(options[:isbn])
          raise EnjuNdl::InvalidIsbn unless lisbn.valid?
        #end

        manifestation = Manifestation.find_by_isbn(lisbn.isbn)
        return manifestation.first if manifestation.present?

        doc = return_xml(lisbn.isbn)
        raise EnjuNdl::RecordNotFound unless doc
        #raise EnjuNdl::RecordNotFound if doc.at('//openSearch:totalResults').content.to_i == 0
        import_record(doc)
      end

      def import_record(doc)
        jpno = doc.at('//dcterms:identifier[@rdf:datatype="http://ndl.go.jp/dcndl/terms/JPNO"]').try(:content)
        identifier = Identifier.where(:body => jpno, :identifier_type_id => IdentifierType.where(:name => 'jpno').first_or_create.id).first
        return identifier.manifestation if identifier

        publishers = get_publishers(doc)

        # title
        title = get_title(doc)

        # date of publication
        pub_date = doc.at('//dcterms:date').try(:content).to_s.gsub(/\./, '-')
        unless pub_date =~ /^\d+(-\d{0,2}){0,2}$/
          pub_date = nil
        end
        if pub_date
          date = pub_date.split('-')
          if date[0] and date[1]
            date = sprintf("%04d-%02d", date[0], date[1])
          else
            date = pub_date
          end
        end

        language = Language.where(:iso_639_2 => get_language(doc)).first
        if language
          language_id = language.id
        else
          language_id = 1
        end

        isbn = Lisbn.new(doc.at('//dcterms:identifier[@rdf:datatype="http://ndl.go.jp/dcndl/terms/ISBN"]').try(:content).to_s).try(:isbn)
        issn = StdNum::ISSN.normalize(doc.at('//dcterms:identifier[@rdf:datatype="http://ndl.go.jp/dcndl/terms/ISSN"]').try(:content))
        issn_l = StdNum::ISSN.normalize(doc.at('//dcterms:identifier[@rdf:datatype="http://ndl.go.jp/dcndl/terms/ISSNL"]').try(:content))

        carrier_type = content_type = nil
        doc.xpath('//dcndl:materialType[@rdf:resource]').each do |d|
          case d.attributes['resource'].try(:content)
          when 'http://ndl.go.jp/ndltype/Book'
            carrier_type = CarrierType.where(:name => 'print').first
            content_type = ContentType.where(:name => 'text').first
          when 'http://purl.org/dc/dcmitype/Sound'
            content_type = ContentType.where(:name => 'audio').first
          when 'http://purl.org/dc/dcmitype/MovingImage'
            content_type = ContentType.where(:name => 'video').first
          when 'http://ndl.go.jp/ndltype/ElectronicResource'
            carrier_type = CarrierType.where(:name => 'file').first
          end
        end

        admin_identifier = doc.at('//dcndl:BibAdminResource[@rdf:about]').attributes["about"].value
        description = doc.at('//dcterms:abstract').try(:content)
        price = doc.at('//dcndl:price').try(:content)
        volume_number_string = doc.at('//dcndl:volume/rdf:Description/rdf:value').try(:content)
        extent = get_extent(doc)
        publication_periodicity = doc.at('//dcndl:publicationPeriodicity').try(:content)
        statement_of_responsibility = doc.xpath('//dcndl:BibResource/dc:creator').map{|e| e.content}.join("; ")

        manifestation = nil
        Patron.transaction do
          publisher_patrons = Patron.import_patrons(publishers)

          manifestation = Manifestation.new(
            :manifestation_identifier => admin_identifier,
            :original_title => title[:manifestation],
            :title_transcription => title[:transcription],
            :title_alternative => title[:alternative],
            :title_alternative_transcription => title[:alternative_transcription],
            # TODO: NDLサーチに入っている図書以外の資料を調べる
            #:carrier_type_id => CarrierType.where(:name => 'print').first.id,
            :language_id => language_id,
            :pub_date => date,
            :description => description,
            :volume_number_string => volume_number_string,
            :price => price,
            :statement_of_responsibility => statement_of_responsibility,
            :start_page => extent[:start_page],
            :end_page => extent[:end_page],
            :height => extent[:height]
          )
          identifier = {}
          if isbn
            identifier[:isbn] = Identifier.new(:body => isbn)
            identifier[:isbn].identifier_type = IdentifierType.where(:name => 'isbn').first_or_create
          end
          if jpno
            identifier[:jpno] = Identifier.new(:body => jpno)
            identifier[:jpno].identifier_type = IdentifierType.where(:name => 'jpno').first_or_create
          end
          if issn
            identifier[:issn] = Identifier.new(:body => issn)
            identifier[:issn].identifier_type = IdentifierType.where(:name => 'issn').first_or_create
          end
          if issn_l
            identifier[:issn_l] = Identifier.new(:body => issn_l)
            identifier[:issn_l].identifier_type = IdentifierType.where(:name => 'issn_l').first_or_create
          end
          manifestation.carrier_type = carrier_type if carrier_type
          manifestation.manifestation_content_type = content_type if content_type
          manifestation.periodical = true if publication_periodicity
          if manifestation.save
            identifier.each do |k, v|
              manifestation.identifiers << v if v.valid?
            end
            manifestation.publishers << publisher_patrons
            create_additional_attributes(doc, manifestation)
            create_series_statement(doc, manifestation)
          end
        end

        #manifestation.send_later(:create_frbr_instance, doc.to_s)
        return manifestation
      end

      def create_additional_attributes(doc, manifestation)
        title = get_title(doc)
        creators = get_creators(doc).uniq
        language = get_language(doc)
        subjects = get_subjects(doc).uniq
        classifications = get_classifications(doc).uniq
        classification_urls = doc.xpath('//dcterms:subject[@rdf:resource]').map{|subject| subject.attributes['resource'].value}

        Patron.transaction do
          creator_patrons = Patron.import_patrons(creators)
          language_id = Language.where(:iso_639_2 => language).first.id rescue 1
          content_type_id = ContentType.where(:name => 'text').first.id rescue 1
          manifestation.creators << creator_patrons

          if defined?(EnjuSubject)
            subject_heading_type = SubjectHeadingType.where(:name => 'ndlsh').first_or_create
            subjects.each do |term|
              subject = Subject.where(:term => term[:term]).first
              unless subject
                subject = Subject.new(term)
                subject.subject_heading_type = subject_heading_type
                subject.subject_type = SubjectType.where(:name => 'concept').first_or_create
              end
              #if subject.valid?
                manifestation.subjects << subject
              #end
              #subject.save!
            end
            if classification_urls
              ndc9_url = classification_urls.map{|url| URI.parse(URI.escape(url))}.select{|u| u.path.split('/').reverse[1] == 'ndc9'}.first
              if ndc9_url
                ndc = ndc9_url.path.split('/').last
                classification_type = ClassificationType.where(:name => 'ndc9').first_or_create
                classification = Classification.new(:category => ndc)
                classification.classification_type = classification_type
                manifestation.classifications << classification if classification.valid?
              end
            end
          end
        end
      end

      def search_ndl(query, options = {})
        options = {:dpid => 'iss-ndl-opac', :item => 'any', :idx => 1, :per_page => 10, :raw => false}.merge(options)
        doc = nil
        results = {}
        startrecord = options[:idx].to_i
        if startrecord == 0
          startrecord = 1
        end
        url = "http://iss.ndl.go.jp/api/opensearch?dpid=#{options[:dpid]}&#{options[:item]}=#{format_query(query)}&cnt=#{options[:per_page]}&idx=#{startrecord}"
        if options[:raw] == true
          open(url).read
        else
          RSS::Rss::Channel.install_text_element("openSearch:totalResults", "http://a9.com/-/spec/opensearchrss/1.0/", "?", "totalResults", :text, "openSearch:totalResults")
          RSS::BaseListener.install_get_text_element "http://a9.com/-/spec/opensearchrss/1.0/", "totalResults", "totalResults="
          feed = RSS::Parser.parse(url, false)
        end
      end

      def normalize_isbn(isbn)
        if isbn.length == 10
          Lisbn.new(isbn).isbn13
        else
          Lisbn.new(isbn).isbn10
        end
      end

      def return_xml(isbn)
        rss = self.search_ndl(isbn, {:dpid => 'iss-ndl-opac', :item => 'isbn'})
        if rss.channel.totalResults.to_i == 0
          isbn = normalize_isbn(isbn)
          rss = self.search_ndl(isbn, {:dpid => 'iss-ndl-opac', :item => 'isbn'})
        end
        if rss.items.first
          doc = Nokogiri::XML(open("#{rss.items.first.link}.rdf").read)
        end
      end

      private
      def get_title(doc)
        title = {
          :manifestation => doc.xpath('//dc:title/rdf:Description/rdf:value').collect(&:content).join(' '),
          :transcription => doc.xpath('//dc:title/rdf:Description/dcndl:transcription').collect(&:content).join(' '),
          :alternative => doc.at('//dcndl:alternative/rdf:Description/rdf:value').try(:content),
          :alternative_transcription => doc.at('//dcndl:alternative/rdf:Description/dcndl:transcription').try(:content)
        }
      end

      def get_creators(doc)
        creators = []
        doc.xpath('//dcterms:creator/foaf:Agent').each do |creator|
          creators << {
            :full_name => creator.at('./foaf:name').content,
            :full_name_transcription => creator.at('./dcndl:transcription').try(:content),
            :patron_identifier => creator.attributes["about"].try(:content)
          }
        end
        creators
      end

      def get_subjects(doc)
        subjects = []
        doc.xpath('//dcterms:subject/rdf:Description').each do |subject|
          subjects << {
            :term => subject.at('./rdf:value').content,
            #:url => subject.attribute('about').try(:content)
          }
        end
        subjects
      end

      def get_classifications(doc)
        classifications = []
        doc.xpath('//dcterms:subject[@rdf:resource]').each do |classification|
          classifications << {
            :url => classification.attributes["resource"].content
          }
        end
        classifications
      end

      def get_language(doc)
        # TODO: 言語が複数ある場合
        language = doc.at('//dcterms:language[@rdf:datatype="http://purl.org/dc/terms/ISO639-2"]').try(:content)
        if language
          language.downcase
        end
      end

      def get_publishers(doc)
        publishers = []
        doc.xpath('//dcterms:publisher/foaf:Agent').each do |publisher|
          publishers << {
            :full_name => publisher.at('./foaf:name').content,
            :full_name_transcription => publisher.at('./dcndl:transcription').try(:content),
            :patron_identifier => publisher.attributes["about"].try(:content)
          }
        end
        return publishers
      end

      def get_extent(doc)
        extent = doc.at('//dcterms:extent').try(:content)
        value = {:start_page => nil, :end_page => nil, :height => nil}
        if extent
          extent = extent.split(';')
          page = extent[0].try(:strip)
          if page =~ /\d+p/
            value[:start_page] = 1
            value[:end_page] = page.to_i
          end
          height = extent[1].try(:strip)
          if height =~ /\d+cm/
            value[:height] = height.to_i
          end
        end
        value
      end

      def create_series_statement(doc, manifestation)
        series = series_title = {}
        series[:title] = doc.at('//dcndl:seriesTitle/rdf:Description/rdf:value').try(:content)
        series[:title_transcription] = doc.at('//dcndl:seriesTitle/rdf:Description/dcndl:seriesTitleTranscription').try(:content)
        if series[:title]
          series_title[:title] = series[:title].split(';')[0].strip
          series_title[:title_transcription] = series[:title_transcription]
        end

        if series_title[:title]
          series_statement = SeriesStatement.where(:original_title => series_title[:title]).first
          unless series_statement
            series_statement = SeriesStatement.new(
              :original_title => series_title[:title],
              :title_transcription => series_title[:title_transcription]
            )
          end
        end

        if series_statement.try(:save)
          manifestation.series_statements << series_statement
        end
        manifestation
      end

      def format_query(query)
        URI.escape(query.to_s.gsub('　',' '))
      end
    end

    class AlreadyImported < StandardError
    end
  end
end
