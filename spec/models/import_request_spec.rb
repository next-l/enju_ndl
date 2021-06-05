require 'rails_helper'

describe ImportRequest do
  fixtures :all
end

# == Schema Information
#
# Table name: import_requests
#
#  id               :bigint           not null, primary key
#  isbn             :string
#  manifestation_id :bigint
#  user_id          :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
