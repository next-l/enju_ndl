# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Question do
  fixtures :all

  it "should respond to search_crd", :vcr => true do
    Question.search_crd(:query_01 => 'library')
  end
end
