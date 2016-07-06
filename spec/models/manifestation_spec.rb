# -*- encoding: utf-8 -*-
require 'rails_helper'

describe Manifestation do
  fixtures :all

  it "should imporrt a bibliographic record", :vcr => true do
    manifestation = Manifestation.import_from_ndl_search(:isbn => '406258087X')
    manifestation.should be_valid
  end

  it "should import isbn", :vcr => true do
    Manifestation.import_isbn('4797327030').should be_valid
  end

  it "should import series statement", :vcr => true do
    manifestation = Manifestation.import_isbn('4106101491')
    manifestation.series_statements.count.should eq  1
    manifestation.series_statements.first.original_title.should eq '新潮新書'
  end
end
