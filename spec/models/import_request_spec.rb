# -*- encoding: utf-8 -*-
require 'spec_helper'

describe ImportRequest do
  fixtures :all

  it "should import isbn", :vcr => true do
    ImportRequest.import_isbn('4797327030').should be_valid
  end
end
