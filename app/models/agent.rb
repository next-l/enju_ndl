require_dependency EnjuBiblio::Engine.config.root.join('app', 'models', 'agent.rb').to_s

class Agent < ApplicationRecord
  include EnjuNdl::EnjuAgent
end

# == Schema Information
#
# Table name: agents
#
#  id                                  :integer          not null, primary key
#  last_name                           :string
#  middle_name                         :string
#  first_name                          :string
#  last_name_transcription             :string
#  middle_name_transcription           :string
#  first_name_transcription            :string
#  corporate_name                      :string
#  corporate_name_transcription        :string
#  full_name                           :string
#  full_name_transcription             :text
#  full_name_alternative               :text
#  created_at                          :datetime
#  updated_at                          :datetime
#  deleted_at                          :datetime
#  zip_code_1                          :string
#  zip_code_2                          :string
#  address_1                           :text
#  address_2                           :text
#  address_1_note                      :text
#  address_2_note                      :text
#  telephone_number_1                  :string
#  telephone_number_2                  :string
#  fax_number_1                        :string
#  fax_number_2                        :string
#  other_designation                   :text
#  place                               :text
#  postal_code                         :string
#  street                              :text
#  locality                            :text
#  region                              :text
#  date_of_birth                       :datetime
#  date_of_death                       :datetime
#  language_id                         :integer          default(1), not null
#  country_id                          :integer          default(1), not null
#  agent_type_id                       :integer          default(1), not null
#  lock_version                        :integer          default(0), not null
#  note                                :text
#  required_role_id                    :integer          default(1), not null
#  required_score                      :integer          default(0), not null
#  email                               :text
#  url                                 :text
#  full_name_alternative_transcription :text
#  birth_date                          :string
#  death_date                          :string
#  agent_identifier                    :string
#  profile_id                          :integer
#
