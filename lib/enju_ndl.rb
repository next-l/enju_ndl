# -*- encoding: utf-8 -*-
require "enju_ndl/engine"
require 'open-uri'
require 'enju_ndl/ndl_search'
require 'enju_ndl/crd'

module EnjuNdl
  module ActsAsMethods
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def enju_ndl_ndl_search
        include EnjuNdl::NdlSearch
      end

      def enju_ndl_crd
        include EnjuNdl::Crd
      end
    end
  end

  class RecordNotFound < StandardError
  end

  class InvalidIsbn < StandardError
  end
end

ActiveRecord::Base.send :include, EnjuNdl::ActsAsMethods
