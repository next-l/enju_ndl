# -*- encoding: utf-8 -*-
module EnjuNdl
  module Crd
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def get_crd_response(options)
        params = {:query_logic => 1, :results_num => 1, :results_num => 200, :sort => 10}.merge(options)
        query = []
        query << "01_#{params[:query_01].to_s.gsub('　', ' ')}" if params[:query_01]
        query << "02_#{params[:query_02].to_s.gsub('　', ' ')}" if params[:query_02]
        delimiter = '.'
        url = "http://crd.ndl.go.jp/refapi/servlet/refapi.RSearchAPI?query=#{URI.escape(query.join(delimiter))}&query_logic=#{params[:query_logic]}&results_get_position=#{params[:results_get_position]}&results_num=#{params[:results_num]}&sort=#{params[:sort]}"

        xml = open(url).read.to_s
      end

      def search_crd(options)
        params = {:page => 1}.merge(options)
        crd_page = params[:page].to_i
        crd_page = 1 if crd_page <= 0
        crd_startrecord = (crd_page - 1) * Question.crd_per_page + 1
        params[:results_get_position] = crd_startrecord
        params[:results_num] = Question.crd_per_page

        xml = get_crd_response(params)
        doc = Nokogiri::XML(xml)

        response = {
          :results_num => doc.at('//xmlns:hit_num').try(:content).to_i,
          :results => []
        }
        doc.xpath('//xmlns:result').each do |result|
          set = {
            :question => result.at('QUESTION').try(:content),
            :reg_id => result.at('REG-ID').try(:content),
            :answer => result.at('ANSWER').try(:content),
            :crt_date => result.at('CRT-DATE').try(:content),
            :solution => result.at('SOLUTION').try(:content),
            :lib_id => result.at('LIB-ID').try(:content),
            :lib_name => result.at('LIB-NAME').try(:content),
            :url => result.at('URL').try(:content),
            :ndc => result.at('NDC').try(:content)
          }
          begin
            set[:keyword] = result.xpath('xmlns:KEYWORD').collect(&:content)
          rescue NoMethodError
            set[:keyword] = []
          end
          response[:results] << set
        end

        crd_count = response[:results_num]
        if crd_count > 1000
          crd_total_count = 1000
        else
          crd_total_count = crd_count
        end

        resources = response[:results]
        crd_results = Kaminari::paginate_array(resources, :total_count => crd_total_count, :page => crd_page).page(crd_page)
      end
    end
  end
end
