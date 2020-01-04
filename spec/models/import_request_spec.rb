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

# == Schema Information
#
# Table name: import_requests
#
#  id               :integer          not null, primary key
#  isbn             :string
#  manifestation_id :integer
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#
