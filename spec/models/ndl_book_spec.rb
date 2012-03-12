# -*- encoding: utf-8 -*-
require 'spec_helper'

describe NdlBook do
  fixtures :languages

  it "should respond to per_page" do
    NdlBook.per_page.should eq 10
  end

  context "search" do
    use_vcr_cassette "enju_ndl/search", :record => :new_episodes
    it "should search bibliographic record" do
      NdlBook.search('library system')[:total_entries].should eq 5163
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
      manifestation.isbn.should eq  '9784839931995'
      manifestation.ndc.should eq "007.64"
      manifestation.nbn.should eq "21816393"
      manifestation.language.name.should eq "Japanese"
      manifestation.creators.first.full_name.should eq '秋葉, 拓哉'
      manifestation.creators.first.full_name_transcription.should eq 'アキバ, タクヤ'
      manifestation.price.should eq 3280
    end

    it "should import bibliographic record that does not have any classifications" do
      manifestation = NdlBook.import_from_sru_response('20286397')
      manifestation.original_title.should eq "アンパンマンとどうぶつえん"
      manifestation.title_transcription.should eq "アンパンマン ト ドウブツエン"
      manifestation.ndc.should be_nil
    end

    it "should import volume_number_string" do
      manifestation = NdlBook.import_from_sru_response('21847424')
      manifestation.volume_number_string.should eq '上'
    end

    it "should import title_alternative" do
      manifestation = NdlBook.import_from_sru_response('21859930')
      manifestation.title_alternative.should eq 'PLATINADATA'
      manifestation.title_alternative_transcription.should eq 'PLATINA DATA'
    end

    it "should import series_statement if the resource is periodical" do
      manifestation = NdlBook.import_from_sru_response('00010852')
      manifestation.original_title.should eq "週刊新潮"
      manifestation.series_statement.original_title.should eq "週刊新潮"
      manifestation.series_statement.periodical.should be_true
    end

    it "should import pud_date is nil" do
      manifestation = NdlBook.import_from_sru_response('00018082')
      manifestation.original_title.should eq "西日本哲学会会報"
      manifestation.pub_date.should be_nil
    end

    it "should import url contain whitespace" do
      manifestation = NdlBook.import_from_sru_response('91044453')
      manifestation.original_title.should eq "ザ・スコット・フィッツジェラルド・ブック"
      manifestation.pub_date.should eq "1991-4"
    end

  end
end
