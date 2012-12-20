# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Manifestation do
  fixtures :all
  use_vcr_cassette "enju_ndl/search", :record => :new_episodes

  it "should imporrt a bibliographic record" do
    manifestation = Manifestation.import_isbn('406258087X')
    manifestation.should be_valid
  end
end
