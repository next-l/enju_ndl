# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Manifestation do
  fixtures :all
  VCR.use_cassette "enju_ndl/search", :record => :new_episodes do

    it "should imporrt a bibliographic record" do
      manifestation = Manifestation.import_from_ndl_search(:isbn => '406258087X')
      manifestation.should be_valid
    end
  end
end
