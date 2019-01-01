class NdlaRecord < ApplicationRecord
  belongs_to :agent
end

# == Schema Information
#
# Table name: ndla_records
#
#  id         :bigint(8)        not null, primary key
#  agent_id   :bigint(8)
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
