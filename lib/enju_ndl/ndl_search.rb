module EnjuNdl
  module NdlSearch
    module ClassMethods
      def rss_import(url)
        doc = Nokogiri::XML(open(url))
        ns = {"dc" => "http://purl.org/dc/elements/1.1/", "xsi" => "http://www.w3.org/2001/XMLSchema-instance", "dcndl" => "http://ndl.go.jp/dcndl/terms/"}
        doc.xpath('//item', ns).each do |item|
          isbn = item.at('./dc:identifier[@xsi:type="dcndl:ISBN"]').try(:content)
          ndl_bib_id = item.at('./dc:identifier[@xsi:type="dcndl:NDLBibID"]').try(:content)
          manifestation = Manifestation.where(:ndl_bib_id => ndl_bib_id).first
          manifestation = Manifestation.find_by_isbn(isbn) unless manifestation
          # FIXME: 日本語決めうち？
          language_id = Language.where(:iso_639_2 => 'jpn').first.id rescue 1
          unless manifestation
            manifestation = self.new(
              :original_title => item.at('./dc:title').content,
              :title_transcription => item.at('./dcndl:titleTranscription').try(:content),
              :isbn => isbn,
              :ndl_bib_id => ndl_bib_id,
              :description => item.at('./dc:description').try(:content),
              :pub_date => item.at('./dc:date').try(:content).try(:gsub, '.', '-'),
              :language_id => language_id
            )
            if manifestation.valid?
              item.xpath('./dc:creator').each_with_index do |creator, i|
                next if i == 0
                patron = Patron.where(:full_name => creator.try(:content)).first
                patron =  Patron.new(:full_name => creator.try(:content)) unless patron
                manifestation.creators << patron if patron.valid?
              end
              item.xpath('./dc:publisher').each_with_index do |publisher, i|
                patron = Patron.where(:full_name => publisher.try(:content)).first
                patron =  Patron.new(:full_name => publisher.try(:content)) unless patron
                manifestation.publishers << patron if patron.valid?
              end
            end
          end
        end
        Sunspot.commit
      end
    end
  end
end
