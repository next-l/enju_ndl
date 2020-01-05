class User < ActiveRecord::Base
  devise :database_authenticatable, #:registerable,
    :recoverable, :rememberable, :trackable, #, :validatable
    :lockable, :lock_strategy => :none, :unlock_strategy => :none

  include EnjuLibrary::EnjuUser
end

Manifestation.include(EnjuNdl::EnjuManifestation)
Question.include(EnjuNdl::EnjuQuestion)
