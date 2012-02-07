# -*- encoding: utf-8 -*-
class NdlBook
  def self.search(query, page = 1, per_page = self.per_page)
    if query
      cnt = self.per_page
      page = 1 if page.to_i < 1
      idx = (page.to_i - 1) * cnt + 1
      doc = Nokogiri::XML(Manifestation.search_ndl(query, {:cnt => cnt, :page => page, :idx => idx, :raw => true}).to_s)
#      raise doc.to_s
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
    url = "http://iss.ndl.go.jp/api/opensearch?dpid=iss-ndl-opac&isbn=#{isbn}&cnt=1&idx=1"
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
    url = "http://iss.ndl.go.jp/api/sru?operation=searchRetrieve&recordSchema=dcndl&&maximumRecords=1&&query=%28jpno=#{jpno}%29"
    xml = open(url).read
    response = Nokogiri::XML(xml).at('//xmlns:recordData')
    return unless response.content
    doc = Nokogiri::XML(response.content)
    Manifestation.import_record(doc)
  end

  attr_accessor :url

  class AlreadyImported < StandardError
  end
end
