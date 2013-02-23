# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Question do
  fixtures :all
  VCR.use_cassette "enju_ndl/crd", :record => :new_episodes do

    it "should respond to search_crd" do
      Question.search_crd(:query_01 => 'library')
    end
  end
end
