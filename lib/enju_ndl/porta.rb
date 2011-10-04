module EnjuNdl
  module Porta
    module ClassMethods
      def import_isbn(isbn)
        isbn = ISBN_Tools.cleanup(isbn)
        raise EnjuNdl::InvalidIsbn unless ISBN_Tools.is_valid?(isbn)

        manifestation = Manifestation.find_by_isbn(isbn)
        return manifestation if manifestation

        doc = return_xml(isbn)
        raise EnjuNdl::RecordNotFound if doc.at('//openSearch:totalResults').content.to_i == 0

        pub_date, language, nbn = nil, nil, nil

        publishers = get_publishers(doc).zip([]).map{|f,t| {:full_name => f, :full_name_transcription => t}}

        # title
        title = get_title(doc)

        # date of publication
        pub_date = doc.at('//dcterms:issued').content.try(:tr, '０-９．', '0-9-')

        language = get_language(doc)
        nbn = doc.at('//dc:identifier[@xsi:type="dcndl:JPNO"]').content
        ndc = doc.at('//dc:subject[@xsi:type="dcndl:NDC"]').try(:content)

        Patron.transaction do
          publisher_patrons = Patron.import_patrons(publishers)
          language_id = Language.where(:iso_639_2 => language).first.id rescue 1

          manifestation = Manifestation.new(
            :original_title => title[:manifestation],
            :title_transcription => title[:transcription],
            # TODO: PORTAに入っている図書以外の資料を調べる
            #:carrier_type_id => CarrierType.where(:name => 'print').first.id,
            :language_id => language_id,
            :isbn => isbn,
            :pub_date => pub_date,
            :nbn => nbn,
            :ndc => ndc
          )
          manifestation.publishers << publisher_patrons
        end

        #manifestation.send_later(:create_frbr_instance, doc.to_s)
        create_frbr_instance(doc, manifestation)
        return manifestation
      end

      def import_isbn!(isbn)
        manifestation = import_isbn(isbn)
        manifestation.save!
        manifestation
      end

      def create_frbr_instance(doc, manifestation)
        title = get_title(doc)
        creators = get_creators(doc).zip([]).map{|f,t| {:full_name => f, :full_name_transcription => t}}
        language = get_language(doc)
        subjects = get_subjects(doc)

        Patron.transaction do
          creator_patrons = Patron.import_patrons(creators)
          language_id = Language.where(:iso_639_2 => language).first.id rescue 1
          content_type_id = ContentType.where(:name => 'text').first.id rescue 1
          manifestation.creators << creator_patrons
          if defined?(Subject)
            subjects.each do |term|
              subject = Subject.where(:term => term).first
              manifestation.subjects << subject if subject
            end
          end
        end
      end

      def search_porta(query, options = {})
        options = {:item => 'any', :startrecord => 1, :per_page => 10, :raw => false}.merge(options)
        doc = nil
        results = {}
        startrecord = options[:startrecord].to_i
        if startrecord == 0
          startrecord = 1
        end
        url = "http://api.porta.ndl.go.jp/servicedp/opensearch?dpid=#{options[:dpid]}&#{options[:item]}=#{URI.escape(query)}&cnt=#{options[:per_page]}&idx=#{startrecord}"
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
          ISBN_Tools.isbn10_to_isbn13(isbn)
        else
          ISBN_Tools.isbn13_to_isbn10(isbn)
        end
      end

      def return_xml(isbn)
        xml = self.search_porta(isbn, {:dpid => 'zomoku', :item => 'isbn', :raw => true}).to_s
        doc = Nokogiri::XML(xml)
        if doc.at('//openSearch:totalResults').content.to_i == 0
          isbn = normalize_isbn(isbn)
          xml = self.search_porta(isbn, {:dpid => 'zomoku', :item => 'isbn', :raw => true}).to_s
          doc = Nokogiri::XML(xml)
        end
        doc
      end

      private
      def get_title(doc)
        title = {
          :manifestation => doc.xpath('//item[1]/title').collect(&:content).join(' ').tr('ａ-ｚＡ-Ｚ０-９　', 'a-zA-Z0-9 ').squeeze(' '),
          :transcription => doc.xpath('//item[1]/dcndl:titleTranscription').collect(&:content).join(' ').tr('ａ-ｚＡ-Ｚ０-９　', 'a-zA-Z0-9 ').squeeze(' '),
          :original => doc.xpath('//dcterms:alternative').collect(&:content).join(' ').tr('ａ-ｚＡ-Ｚ０-９　', 'a-zA-Z0-9 ').squeeze(' ')
        }
      end

      def get_creators(doc)
        creators = []
        doc.xpath('//item[1]/dc:creator[@xsi:type="dcndl:NDLNH"]').each do |creator|
          creators << creator.content.gsub('‖', '').tr('ａ-ｚＡ-Ｚ０-９　', 'a-zA-Z0-9 ')
        end
        creators
      end

      def get_subjects(doc)
        subjects = []
        doc.xpath('//item[1]/dc:subject[@xsi:type="dcndl:NDLSH"]').each do |subject|
          subjects << subject.content.tr('ａ-ｚＡ-Ｚ０-９　‖', 'a-zA-Z0-9 ')
        end
        return subjects
      end

      def get_language(doc)
        # TODO: 言語が複数ある場合
        language = doc.xpath('//item[1]/dc:language[@xsi:type="dcterms:ISO639-2"]').first.content.downcase
      end

      def get_publishers(doc)
        publishers = []
        doc.xpath('//item[1]/dc:publisher').each do |publisher|
          publishers << publisher.content.tr('ａ-ｚＡ-Ｚ０-９　‖', 'a-zA-Z0-9 ')
        end
        return publishers
      end
    end
  end
end
