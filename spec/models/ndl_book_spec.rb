# -*- encoding: utf-8 -*-
require 'spec_helper'

describe NdlBook do
  fixtures :all

  it "should respond to per_page" do
    NdlBook.per_page.should eq 10
  end

  context "search" do
    it "should search bibliographic record", :vcr => true do
      NdlBook.search('library system')[:total_entries].should eq 5295
    end

    it "should not distinguish double byte space from one-byte space in a query", :vcr => true do
      NdlBook.search("カミュ ペスト")[:total_entries].should eq NdlBook.search("カミュ　ペスト")[:total_entries]
    end   
  end

  context "import" do
    it "should import bibliographic record", :vcr => true do
      manifestation = NdlBook.import_from_sru_response('R100000002-I000010980901-00')
      manifestation.manifestation_identifier.should eq 'http://iss.ndl.go.jp/books/R100000002-I000010980901-00'
      manifestation.identifier_contents(:isbn).should eq ['9784839931995']
      manifestation.classifications.pluck(:category).should eq ["007.64"]
      manifestation.identifier_contents(:iss_itemno).should eq ["R100000002-I000010980901-00"]
      manifestation.identifier_contents(:jpno).should eq ["21816393"]
      manifestation.language.name.should eq "Japanese"
      manifestation.creators.first.full_name.should eq '秋葉, 拓哉'
      manifestation.creators.first.full_name_transcription.should eq 'アキバ, タクヤ'
      manifestation.creators.first.agent_identifier.should eq 'http://id.ndl.go.jp/auth/entity/01208840'
      manifestation.price.should eq 3280
      manifestation.start_page.should eq 1
      manifestation.end_page.should eq 315
      manifestation.height.should eq 24.0
      manifestation.subjects.size.should eq 1
      manifestation.subjects.first.subject_heading_type.name.should eq 'ndlsh'
      manifestation.subjects.first.term.should eq 'プログラミング (コンピュータ)'
      manifestation.statement_of_responsibility.should eq '秋葉拓哉, 岩田陽一, 北川宜稔 著; Usu-ya 編'
    end

    it "should import bibliographic record that does not have any classifications", :vcr => true do
      manifestation = NdlBook.import_from_sru_response('R100000002-I000003641700-00')
      manifestation.original_title.should eq "アンパンマンとどうぶつえん"
      manifestation.title_transcription.should eq "アンパンマン ト ドウブツエン"
      manifestation.ndc.should be_nil
    end

    it "should import volume_number_string", :vcr => true do
      manifestation = NdlBook.import_from_sru_response('R100000002-I000011037191-00')
      manifestation.volume_number_string.should eq '上'
    end

    it "should import title_alternative", :vcr => true do
      manifestation = NdlBook.import_from_sru_response('R100000002-I000010926074-00')
      manifestation.title_alternative.should eq 'PLATINADATA'
      manifestation.title_alternative_transcription.should eq 'PLATINA DATA'
    end

    it "should import series_statement", :vcr => true do
      manifestation = NdlBook.import_from_sru_response('R100000002-I000004152429-00')
      manifestation.original_title.should eq "ズッコケ三人組のダイエット講座"
      manifestation.series_statements.first.original_title.should eq "ポプラ社文庫. ズッコケ文庫"
      manifestation.periodical.should be_false
    end

    it "should import series_statement if the resource is periodical", :vcr => true do
      manifestation = NdlBook.import_from_sru_response('R100000039-I001413988-00')
      manifestation.original_title.should eq "週刊新潮"
      #manifestation.series_statements.first.original_title.should eq "週刊新潮"
      manifestation.periodical.should be_true
      end

    it "should import pud_date is nil", :vcr => true do
      manifestation = NdlBook.import_from_sru_response('R100000002-I000000017951-00')
      manifestation.original_title.should eq "西日本哲学会会報"
      manifestation.pub_date.should be_nil
    end

    it "should import url contain whitespace", :vcr => true do
      manifestation = NdlBook.import_from_sru_response('R100000002-I000002109818-00')
      manifestation.original_title.should eq "ザ・スコット・フィッツジェラルド・ブック"
      manifestation.pub_date.should eq "1991-04"
    end

    it "should import audio cd", :vcr => true do
      manifestation = NdlBook.import_from_sru_response('R100000002-I000010273695-00')
      manifestation.original_title.should eq "劇場版天元突破グレンラガン螺巌篇サウンドトラック・プラス"
      manifestation.manifestation_content_type.name.should eq 'audio'
    end

    it "should import video dvd", :vcr => true do
      manifestation = NdlBook.import_from_sru_response('R100000002-I000009149656-00')
      manifestation.original_title.should eq "天元突破グレンラガン"
      manifestation.manifestation_content_type.name.should eq 'video'
    end

    it "should not get volume number if book has not volume", :vcr => true do
      NdlBook.search('978-4-04-874013-5')[:items].first.title.should eq "天地明察"
    end

    it "should get volume number", :vcr => true do
      NdlBook.search('978-4-04-100292-6')[:items].first.volume.should eq "下"
    end

    it "should not get volume number if book has not volume", :vcr => true do
      NdlBook.search('978-4-04-874013-5')[:items].first.volume.should eq ""
    end

    it "should get series title", :vcr => true do
      book = NdlBook.search("4840114404")[:items].first
      book.series_title.should eq "マジック・ツリーハウス ; 15"
    end

    it "should not get series title if book has not series title", :vcr => true do
      book = NdlBook.search("4788509105")[:items].first
      book.series_title.should eq ""
    end
  end
end
