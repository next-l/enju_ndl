require 'rails_helper'

describe Manifestation do
  fixtures :all

  it "should import a bibliographic record", vcr: true do
    manifestation = Manifestation.import_from_ndl_search(isbn: '406258087X')
    manifestation.should be_valid
  end

  it "should import isbn", vcr: true do
    Manifestation.import_isbn('4797327030').should be_valid
  end

  it "should import series statement", vcr: true do
    manifestation = Manifestation.import_isbn('4106101491')
    manifestation.series_statements.count.should eq  1
    manifestation.series_statements.first.original_title.should eq '新潮新書'
  end

  it "should import with ndl_bib_id", vcr: true do
    manifestation = Manifestation.import_ndl_bib_id("000000471440")
    expect(manifestation).to be_valid
    expect(manifestation.original_title).to eq "化学"
  end

  it "should import dcterms:issued", vcr: true do
    manifestation = Manifestation.import_isbn("0262220733")
    expect(manifestation).to be_valid
    expect(manifestation.year_of_publication).to eq 2005
    expect(manifestation.pub_date).to eq '2005'
    expect(manifestation.date_of_publication).to eq Time.zone.parse('2005-01-01')
  end
end
