# -*- encoding: utf-8 -*-
class Book
  def self.search(query, page = 1, per_page = self.per_page)
    if query
      cnt = self.per_page
      page = 1 if page.to_i < 1
      idx = (page.to_i - 1) * cnt + 1
      url = "http://api.porta.ndl.go.jp/servicedp/opensearch?dpid=zomoku&any=#{URI.encode(query.strip)}&cnt=#{cnt}&idx=#{idx}"
      Rails.logger.debug url
      xml = open(url).read
      doc = Nokogiri::XML(xml)
      items = doc.xpath('//channel/item')
      total_entries = doc.at('//channel/openSearch:totalResults').content.to_i
      {:items => items, :total_entries => total_entries}
    else
      {:items => [], :total_entries => 0}
    end
  end

  def self.per_page
    10
  end

  def self.find_by_isbn(isbn)
    url = "http://api.porta.ndl.go.jp/servicedp/opensearch?dpid=zomoku&isbn=#{isbn}&cnt=1&idx=1"
    Rails.logger.debug url
    xml = open(url).read
    doc = Nokogiri::XML(xml).at('//channel/item')
    {
      :title => doc.at('./title').content,
      :publisher => doc.xpath('./dc:publisher').collect(&:content).join(' '),
      :creator => doc.xpath('./dc:creator[@xsi:type="dcndl:NDLNH"]').collect(&:content).join(' '),
      :isbn => doc.at('./dc:identifier[@xsi:type="dcndl:ISBN"]').try(:content).to_s
    }
  end

  def self.import_from_sru_response(jpno)
    manifestation = Manifestation.where(:nbn => jpno).first
    return if manifestation
    response = Nokogiri::XML(open("http://api.porta.ndl.go.jp/servicedp/SRUDp?operation=searchRetrive&maximumRecords=10&recordSchema=dcndl_porta&query=%28jpno=#{jpno}%29")).at('//xmlns:recordData', 'xmlns' => "http://www.loc.gov/zing/srw/")
    return unless response.content
    doc = Nokogiri::XML(response.content)
    title = {
      :manifestation => doc.xpath('//dc:title').collect(&:content).join(' ').tr('ａ-ｚＡ-Ｚ０-９　', 'a-zA-Z0-9 ').squeeze(' '),
      :transcription => doc.xpath('//dcndl:titleTranscription').collect(&:content).join(' ').tr('ａ-ｚＡ-Ｚ０-９　', 'a-zA-Z0-9 ').squeeze(' '),
      :original => doc.xpath('//dcterms:alternative').collect(&:content).join(' ').tr('ａ-ｚＡ-Ｚ０-９　', 'a-zA-Z0-9 ').squeeze(' ')
    }
    language = Language.where(
      :iso_639_2 => doc.at('//dc:language[@xsi:type="dcterms:ISO639-2"]').content.downcase
    ).first
    manifestation = Manifestation.new(
      :original_title => title[:manifestation],
      :title_transcription => title[:title_transcription],
      :title_alternative => title[:original],
      :pub_date => doc.at('//dcterms:issued').content.try(:tr, '０-９．', '0-9-'),
      :isbn => doc.at('//dc:identifier[@xsi:type="dcndl:ISBN"]').try(:content),
      :nbn => doc.at('//dc:identifier[@xsi:type="dcndl:JPNO"]').content,
      :ndc => doc.at('//dc:subject[@xsi:type="dcndl:NDC"]').try(:content)
    )
    manifestation.language = language if language
    creators = []
    doc.xpath('//dc:creator[@xsi:type="dcndl:NDLNH"]').each do |creator|
      creators << creator.content.tr('ａ-ｚＡ-Ｚ０-９　‖', 'a-zA-Z0-9 ')
    end
    patron_creators = Patron.import_patrons(creators.zip([]).map{|f,t| {:full_name => f, :full_name_transcription => t}})
    publishers = []
    doc.xpath('//dc:publisher').each do |publisher|
      publishers << publisher.content.tr('ａ-ｚＡ-Ｚ０-９　‖', 'a-zA-Z0-9 ')
    end
    patron_publishers = Patron.import_patrons(publishers.zip([]).map{|f,t| {:full_name => f, :full_name_transcription => t}})
    manifestation.creators << patron_creators
    manifestation.publishers << patron_publishers
    manifestation.save!
    manifestation
  end

  attr_accessor :url
end

