require_dependency EnjuBiblio::Engine.config.root.join('app', 'models', 'import_request.rb').to_s

class ImportRequest < ApplicationRecord
  include EnjuNdl::EnjuManifestation
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
