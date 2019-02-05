# frozen_string_literal: true

module EnjuNdl
  module EnjuManifestation
    extend ActiveSupport::Concern

    included do
      has_one :jpno_record
      searchable do
        string :jpno do
          jpno_record.try(:body)
        end
      end

      def self.import_isbn(isbn)
        self.import_from_ndl_search(isbn: isbn)
      end

      # Use http://www.ndl.go.jp/jp/dlib/standards/opendataset/aboutIDList.txt
      def self.import_ndl_bib_id(ndl_bib_id)
        url = "http://iss.ndl.go.jp/books/R100000002-I#{ndl_bib_id}-00.rdf"
        doc = Nokogiri::XML(Faraday.get(url).body)
        import_record(doc)
      end

      def self.import_from_ndl_search(options)
        lisbn = Lisbn.new(options[:isbn])
        raise Manifestation::InvalidIsbn unless lisbn.valid?

        isbn_record = IsbnRecord.find_by(body: lisbn.isbn13) || IsbnRecord.find_by(body: lisbn.isbn10)
        if isbn_record
          manifestation = isbn_record.manifestations.first
          return manifestation if manifestation
        end

        doc = return_xml(lisbn.isbn)
        raise Manifestation::RecordNotFound unless doc

        import_record(doc)
      end

      def self.import_record(doc)
        iss_itemno = URI.parse(doc.at('//dcndl:BibAdminResource[@rdf:about]').values.first).path.split('/').last

        jpno = doc.at('//dcterms:identifier[@rdf:datatype="http://ndl.go.jp/dcndl/terms/JPNO"]').try(:content)

        publishers = get_publishers(doc)

        # title
        title = get_title(doc)

        # date of publication
        pub_date = doc.at('//dcterms:issued').try(:content).to_s.tr('.', '-')
        pub_date = nil unless pub_date =~ /^\d+(-\d{0,2}){0,2}$/
        if pub_date
          date = pub_date.split('-')
          date = if date[0] && date[1]
                   format('%04d-%02d', date[0], date[1])
                 else
                   pub_date
                 end
        end

        language = Language.find_by(iso_639_2: get_language(doc))
        language_id = if language
                        language.id
                      else
                        1
                      end

        isbn = Lisbn.new(doc.at('//dcterms:identifier[@rdf:datatype="http://ndl.go.jp/dcndl/terms/ISBN"]').try(:content).to_s)
        issn = StdNum::ISSN.normalize(doc.at('//dcterms:identifier[@rdf:datatype="http://ndl.go.jp/dcndl/terms/ISSN"]').try(:content))
        issn_l = StdNum::ISSN.normalize(doc.at('//dcterms:identifier[@rdf:datatype="http://ndl.go.jp/dcndl/terms/ISSNL"]').try(:content))

        carrier_type = content_type = nil
        is_serial = nil
        doc.xpath('//dcndl:materialType[@rdf:resource]').each do |d|
          case d.attributes['resource'].try(:content)
          when 'http://ndl.go.jp/ndltype/Book'
            carrier_type = CarrierType.find_by(name: 'volume')
            content_type = ContentType.find_by(name: 'text')
          when 'http://ndl.go.jp/ndltype/Braille'
            carrier_type = CarrierType.find_by(name: 'volume')
            content_type = ContentType.find_by(name: 'tactile_text')
          # when 'http://ndl.go.jp/ndltype/ComputerProgram'
          #  content_type = ContentType.where(name: 'computer_program').first
          when 'http://ndl.go.jp/ndltype/ElectronicResource'
            carrier_type = CarrierType.find_by(name: 'online_resource')
          when 'http://ndl.go.jp/ndltype/Journal'
            is_serial = true
            carrier_type = CarrierType.find_by(name: 'volume')
          when 'http://ndl.go.jp/ndltype/Map'
            carrier_type = CarrierType.find_by(name: 'volume')
            content_type = ContentType.find_by(name: 'cartographic_image')
          when 'http://ndl.go.jp/ndltype/Music'
            carrier_type = CarrierType.find_by(name: 'volume')
            content_type = ContentType.find_by(name: 'performed_music')
          when 'http://ndl.go.jp/ndltype/MusicScore'
            carrier_type = CarrierType.find_by(name: 'volume')
            content_type = ContentType.find_by(name: 'notated_music')
          when 'http://ndl.go.jp/ndltype/Painting'
            carrier_type = CarrierType.find_by(name: 'volume')
            content_type = ContentType.find_by(name: 'still_image')
          when 'http://ndl.go.jp/ndltype/Photograph'
            carrier_type = CarrierType.find_by(name: 'volume')
            content_type = ContentType.find_by(name: 'still_image')
          when 'http://ndl.go.jp/ndltype/PicturePostcard'
            carrier_type = CarrierType.find_by(name: 'volume')
            content_type = ContentType.find_by(name: 'still_image')
          when 'http://purl.org/dc/dcmitype/MovingImage'
            carrier_type = CarrierType.find_by(name: 'volume')
            content_type = ContentType.find_by(name: 'two_dimensional_moving_image')
          when 'http://purl.org/dc/dcmitype/Sound'
            carrier_type = CarrierType.find_by(name: 'volume')
            content_type = ContentType.find_by(name: 'sounds')
          when 'http://purl.org/dc/dcmitype/StillImage'
            carrier_type = CarrierType.find_by(name: 'volume')
            content_type = ContentType.find_by(name: 'still_image')
          else
            carrier_type = CarrierType.find_by(name: 'volume')
          end
        end

        admin_identifier = doc.at('//dcndl:BibAdminResource[@rdf:about]').attributes['about'].value
        description = doc.at('//dcterms:abstract').try(:content)
        price = doc.at('//dcndl:price').try(:content)
        volume_number_string = doc.at('//dcndl:volume/rdf:Description/rdf:value').try(:content)
        extent = get_extent(doc)
        publication_periodicity = doc.at('//dcndl:publicationPeriodicity').try(:content)
        statement_of_responsibility = doc.xpath('//dcndl:BibResource/dc:creator').map(&:content).join('; ')
        publication_place = doc.at('//dcterms:publisher/foaf:Agent/dcndl:location').try(:content)
        edition_string = doc.at('//dcndl:edition').try(:content)

        manifestation = Manifestation.where(manifestation_identifier: admin_identifier).first
        return manifestation if manifestation

        Agent.transaction do
          publisher_agents = Agent.import_agents(publishers)

          manifestation = Manifestation.new(
            manifestation_identifier: admin_identifier,
            original_title: title[:manifestation],
            title_transcription: title[:transcription],
            title_alternative: title[:alternative],
            title_alternative_transcription: title[:alternative_transcription],
            # TODO: NDLサーチに入っている図書以外の資料を調べる
            #:carrier_type_id => CarrierType.where(name: 'print').first.id,
            language_id: language_id,
            pub_date: date,
            description: description,
            volume_number_string: volume_number_string,
            price: price,
            statement_of_responsibility: statement_of_responsibility,
            start_page: extent[:start_page],
            end_page: extent[:end_page],
            height: extent[:height],
            extent: extent[:extent],
            dimensions: extent[:dimensions],
            publication_place: publication_place,
            edition_string: edition_string
          )
          manifestation.serial = true if is_serial
          identifier = {}
          if isbn.present?
            isbn_record = IsbnRecord.find_by(body: isbn.isbn13) || IsbnRecord.find_by(body: isbn.isbn10)
            isbn_record = IsbnRecord.create(body: isbn.isbn13) unless isbn_record
          end
          manifestation.jpno_record = JpnoRecord.where(body: jpno).first_or_initialize if jpno.present?
          issn_record = IssnRecord.where(body: issn).first_or_initialize if issn
          manifestation.carrier_type = carrier_type if carrier_type
          manifestation.manifestation_content_type = content_type if content_type
          if manifestation.save
            manifestation.isbn_records << isbn_record if isbn_record
            manifestation.issn_records << issn_record if issn_record
            create_additional_attributes(doc, manifestation)
            identifier.each do |_k, v|
              manifestation.identifiers << v if v.valid?
            end
            manifestation.publishers << publisher_agents
            if is_serial
              series_statement = SeriesStatement.new(
                original_title: title[:manifestation],
                title_alternative: title[:alternative],
                title_transcription: title[:transcription],
                series_master: true
              )
              if series_statement.valid?
                manifestation.series_statements << series_statement
              end
            else
              create_series_statement(doc, manifestation)
            end
          end
        end
        manifestation
      end

      def self.create_additional_attributes(doc, manifestation)
        title = get_title(doc)
        creators = get_creators(doc).uniq
        subjects = get_subjects(doc).uniq
        classifications = get_classifications(doc).uniq
        classification_urls = doc.xpath('//dcterms:subject[@rdf:resource]').map { |subject| subject.attributes['resource'].value }

        Agent.transaction do
          creator_agents = Agent.import_agents(creators)
          content_type_id = begin
                              ContentType.find_by(name: 'text').id
                            rescue
                              1
                            end
          manifestation.creators << creator_agents

          if defined?(EnjuSubject)
            subject_heading_type = SubjectHeadingType.where(name: 'ndlsh').first_or_create!
            subjects.each do |term|
              subject = Subject.find_by(term: term[:term])
              unless subject
                subject = Subject.new(term)
                subject.subject_heading_type = subject_heading_type
                subject.subject_type = SubjectType.where(name: 'concept').first_or_create!
              end
              # if subject.valid?
              manifestation.subjects << subject
              # end
              # subject.save!
            end
            if classification_urls
              classification_urls.each do |url|
                begin
                  ndc_url = URI.parse(URI.escape(url))
                rescue URI::InvalidURIError
                end
                next unless ndc_url && (ndc_url.path.split('/').reverse[1] == 'ndc9')
                ndc_type = 'ndc9'
                ndc = ndc_url.path.split('/').last
                classification_type = ClassificationType.where(name: ndc_type).first_or_create!
                classification = Classification.new(category: ndc)
                classification.classification_type = classification_type
                manifestation.classifications << classification if classification.valid?
              end
            end
            ndc8 = doc.xpath('//dc:subject[@rdf:datatype="http://ndl.go.jp/dcndl/terms/NDC8"]').first
            if ndc8
              classification_type = ClassificationType.where(name: 'ndc8').first_or_create!
              classification = Classification.new(category: ndc8.content)
              classification.classification_type = classification_type
              manifestation.classifications << classification if classification.valid?
            end
          end
        end
      end

      def self.search_ndl(query, options = {})
        options = { dpid: 'iss-ndl-opac', item: 'any', idx: 1, per_page: 10, raw: false, mediatype: 1 }.merge(options)
        startrecord = options[:idx].to_i
        startrecord = 1 if startrecord == 0
        url = "http://iss.ndl.go.jp/api/opensearch?dpid=#{options[:dpid]}&#{options[:item]}=#{format_query(query)}&cnt=#{options[:per_page]}&idx=#{startrecord}&mediatype=#{options[:mediatype]}"
        if options[:raw] == true
          Faraday.get(url).body
        else
          RSS::Rss::Channel.install_text_element('openSearch:totalResults', 'http://a9.com/-/spec/opensearchrss/1.0/', '?', 'totalResults', :text, 'openSearch:totalResults')
          RSS::BaseListener.install_get_text_element 'http://a9.com/-/spec/opensearchrss/1.0/', 'totalResults', 'totalResults='
          RSS::Parser.parse(url, false)
        end
      end

      def self.normalize_isbn(isbn)
        if isbn.length == 10
          Lisbn.new(isbn).isbn13
        else
          Lisbn.new(isbn).isbn10
        end
      end

      def self.return_xml(isbn)
        rss = search_ndl(isbn, dpid: 'iss-ndl-opac', item: 'isbn')
        if rss.channel.totalResults.to_i == 0
          isbn = normalize_isbn(isbn)
          rss = search_ndl(isbn, dpid: 'iss-ndl-opac', item: 'isbn')
        end
        if rss.items.first
          Nokogiri::XML(Faraday.get("#{rss.items.first.link}.rdf").body)
        end
      end

      private

      def self.get_title(doc)
        title = {
          manifestation: doc.xpath('//dc:title/rdf:Description/rdf:value').collect(&:content).join(' '),
          transcription: doc.xpath('//dc:title/rdf:Description/dcndl:transcription').collect(&:content).join(' '),
          alternative: doc.at('//dcndl:alternative/rdf:Description/rdf:value').try(:content),
          alternative_transcription: doc.at('//dcndl:alternative/rdf:Description/dcndl:transcription').try(:content)
        }
        volume_title = doc.at('//dcndl:volume_title/rdf:Description/rdf:value').try(:content)
        volume_title_transcription = doc.at('//dcndl:volume_title/rdf:Description/dcndl:transcription').try(:content)
        title[:manifestation] << " #{volume_title}" if volume_title
        title[:transcription] << " #{volume_title_transcription}" if volume_title_transcription
        title
      end

      def self.get_creators(doc)
        creators = []
        doc.xpath('//dcterms:creator/foaf:Agent').each do |creator|
          creators << {
            full_name: creator.at('./foaf:name').content,
            full_name_transcription: creator.at('./dcndl:transcription').try(:content),
            agent_identifier: creator.attributes['about'].try(:content)
          }
        end
        creators
      end

      def self.get_subjects(doc)
        subjects = []
        doc.xpath('//dcterms:subject/rdf:Description').each do |subject|
          subjects << {
            term: subject.at('./rdf:value').content,
            #:url => subject.attribute('about').try(:content)
          }
        end
        subjects
      end

      def self.get_classifications(doc)
        classifications = []
        doc.xpath('//dcterms:subject[@rdf:resource]').each do |classification|
          classifications << {
            url: classification.attributes['resource'].content
          }
        end
        classifications
      end

      def self.get_language(doc)
        # TODO: 言語が複数ある場合
        language = doc.at('//dcterms:language[@rdf:datatype="http://purl.org/dc/terms/ISO639-2"]').try(:content)
        language.downcase if language
      end

      def self.get_publishers(doc)
        publishers = []
        doc.xpath('//dcterms:publisher/foaf:Agent').each do |publisher|
          publishers << {
            full_name: publisher.at('./foaf:name').content,
            full_name_transcription: publisher.at('./dcndl:transcription').try(:content),
            agent_identifier: publisher.attributes['about'].try(:content)
          }
        end
        publishers
      end

      def self.get_extent(doc)
        extent = doc.at('//dcterms:extent').try(:content)
        value = { start_page: nil, end_page: nil, height: nil }
        if extent
          extent = extent.split(';')
          page = extent[0].try(:strip)
          value[:extent] = page
          if page =~ /\d+p/
            value[:start_page] = 1
            value[:end_page] = page.to_i
          end
          height = extent[1].try(:strip)
          value[:dimensions] = height
          value[:height] = height.to_i if height =~ /\d+cm/
        end
        value
      end

      def self.create_series_statement(doc, manifestation)
        series = series_title = {}
        series[:title] = doc.at('//dcndl:seriesTitle/rdf:Description/rdf:value').try(:content)
        series[:title_transcription] = doc.at('//dcndl:seriesTitle/rdf:Description/dcndl:transcription').try(:content)
        series[:creator] = doc.at('//dcndl:seriesCreator').try(:content)
        if series[:title]
          series_title[:title] = series[:title].split(';')[0].strip
          if series[:title_transcription]
            series_title[:title_transcription] = series[:title_transcription].split(';')[0].strip
          end
        end

        if series_title[:title]
          series_statement = SeriesStatement.find_by(original_title: series_title[:title])
          series_statement ||= SeriesStatement.new(
            original_title: series_title[:title],
            title_transcription: series_title[:title_transcription],
            creator_string: series[:creator]
          )
        end

        if series_statement.try(:save)
          manifestation.series_statements << series_statement
        end
        manifestation
      end

      def self.format_query(query)
        URI.escape(query.to_s.tr('　', ' '))
      end
    end

    class AlreadyImported < StandardError
    end
  end
end
