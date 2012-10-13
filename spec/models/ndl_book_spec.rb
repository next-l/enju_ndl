# -*- encoding: utf-8 -*-
require 'spec_helper'

describe NdlBook do
  fixtures :all

  it "should respond to per_page" do
    NdlBook.per_page.should eq 10
  end

  context "search" do
    use_vcr_cassette "enju_ndl/search", :record => :new_episodes
    it "should search bibliographic record" do
      NdlBook.search('library system')[:total_entries].should eq 5163
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
      manifestation.creators.first.patron_identifier.should eq 'http://id.ndl.go.jp/auth/entity/01208840'
      manifestation.price.should eq 3280
      manifestation.start_page.should eq 1
      manifestation.end_page.should eq 315
      manifestation.height.should eq 24.0
      manifestation.subjects.size.should eq 1
      manifestation.subjects.first.subject_heading_types.first.name.should eq 'ndlsh'
      manifestation.subjects.first.term.should eq 'プログラミング (コンピュータ)'
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

    it "should import series_statement" do
      manifestation = NdlBook.import_from_sru_response('20408556')
      manifestation.original_title.should eq "ズッコケ三人組のダイエット講座"
      manifestation.series_statement.original_title.should eq "ポプラ社文庫. ズッコケ文庫"
      manifestation.series_statement.periodical.should be_false
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
      manifestation.pub_date.should eq "1991-04"
    end

    it "should import audio cd" do
      manifestation = NdlBook.import_from_sru_response('21620217')
      manifestation.original_title.should eq "劇場版天元突破グレンラガン螺巌篇サウンドトラック・プラス"
      manifestation.manifestation_content_type.name.should eq 'audio'
    end

    it "should import video dvd" do
      manifestation = NdlBook.import_from_sru_response('21374190')
      manifestation.original_title.should eq "天元突破グレンラガン"
      manifestation.manifestation_content_type.name.should eq 'video'
    end

    it "should get volume number" do
      NdlBook.search('978-4-04-100292-6')[:items].first.title.should eq "天地明察 下"
    end
  end
end
