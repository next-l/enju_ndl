require_dependency EnjuBiblio::Engine.config.root.join('app', 'models', 'import_request.rb').to_s

class ImportRequest < ApplicationRecord
  # include EnjuNdl::EnjuManifestation
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
