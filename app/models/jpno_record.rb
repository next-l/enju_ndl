class JpnoRecord < ApplicationRecord
  belongs_to :manifestation
end

# == Schema Information
#
# Table name: jpno_records
#
#  id               :integer          not null, primary key
#  body             :string           not null
#  manifestation_id :uuid             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
