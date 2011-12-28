# -*- encoding: utf-8 -*-
require 'spec_helper'

describe NdlBook do
  it "should respond to per_page" do
    NdlBook.per_page.should eq 10
  end

  context "search" do
    use_vcr_cassette "enju_ndl/search", :record => :new_episodes
    it "should search bibliographic record" do
      NdlBook.search('library system')[:total_entries].should eq 5159
    end
  end

  context "find_by_isbn" do
    use_vcr_cassette "enju_ndl/find_by_isbn", :record => :new_episodes
    it "should find bibliographic record by isbn" do
      NdlBook.find_by_isbn('9784839931995')[:title].should eq "プログラミングコンテストチャレンジブック : 問題解決のアルゴリズム活用力とコーディングテクニックを鍛える"
    end
  end

  context "import" do
    use_vcr_cassette "enju_ndl/import", :record => :new_episodes
    it "should import bibliographic record" do
      manifestation = NdlBook.import_from_sru_response('21816393')
      manifestation.ndc.should eq "007.64"
      manifestation.nbn.should eq "21816393"
    end
  end
end
