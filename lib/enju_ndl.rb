# -*- encoding: utf-8 -*-
require "enju_ndl/engine"
require 'enju_ndl/ndl_search'
require 'enju_ndl/crd'
require 'enju_ndl/porta'

module EnjuNdl
  module ActsAsMethods
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def enju_ndl_search
        include EnjuNdl::NdlSearch::ClassMethods
      end

      def enju_ndl_crd
        include EnjuNdl::Crd::ClassMethods
      end

      def enju_ndl_porta
        include EnjuNdl::Porta::ClassMethods
      end
    end
  end

  class RecordNotFound < StandardError
  end

  class InvalidIsbn < StandardError
  end
end

ActiveRecord::Base.send :include, EnjuNdl::ActsAsMethods
