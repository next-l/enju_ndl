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

# == Schema Information
#
# Table name: manifestations
#
#  id                              :bigint           not null, primary key
#  original_title                  :text             not null
#  title_alternative               :text
#  title_transcription             :text
#  classification_number           :string
#  manifestation_identifier        :string
#  date_of_publication             :datetime
#  date_copyrighted                :datetime
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  access_address                  :string
#  language_id                     :integer          default(1), not null
#  carrier_type_id                 :integer          default(1), not null
#  start_page                      :integer
#  end_page                        :integer
#  height                          :integer
#  width                           :integer
#  depth                           :integer
#  price                           :integer
#  fulltext                        :text
#  volume_number_string            :string
#  issue_number_string             :string
#  serial_number_string            :string
#  edition                         :integer
#  note                            :text
#  repository_content              :boolean          default(FALSE), not null
#  lock_version                    :integer          default(0), not null
#  required_role_id                :integer          default(1), not null
#  required_score                  :integer          default(0), not null
#  frequency_id                    :integer          default(1), not null
#  subscription_master             :boolean          default(FALSE), not null
#  attachment_file_name            :string
#  attachment_content_type         :string
#  attachment_file_size            :integer
#  attachment_updated_at           :datetime
#  title_alternative_transcription :text
#  description                     :text
#  abstract                        :text
#  available_at                    :datetime
#  valid_until                     :datetime
#  date_submitted                  :datetime
#  date_accepted                   :datetime
#  date_captured                   :datetime
#  pub_date                        :string
#  edition_string                  :string
#  volume_number                   :integer
#  issue_number                    :integer
#  serial_number                   :integer
#  content_type_id                 :integer          default(1)
#  year_of_publication             :integer
#  attachment_meta                 :text
#  month_of_publication            :integer
#  fulltext_content                :boolean
#  doi                             :string
#  serial                          :boolean
#  statement_of_responsibility     :text
#  publication_place               :text
#  extent                          :text
#  dimensions                      :text
#  memo                            :text
#
