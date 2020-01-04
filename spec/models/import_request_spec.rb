require 'rails_helper'

describe ImportRequest do
  fixtures :all

  it "should import isbn", vcr: true do
    ImportRequest.import_isbn('4797327030').should be_valid
  end

  it "should import a foreign book", vcr: true do
    ImportRequest.import_isbn('0262220733').should be_valid
  end
end
