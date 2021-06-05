class User < ApplicationRecord
  devise :database_authenticatable, #:registerable,
    :recoverable, :rememberable, :trackable, #, :validatable
    :lockable, :lock_strategy => :none, :unlock_strategy => :none

  include EnjuLibrary::EnjuUser
end

Manifestation.include(EnjuSubject::EnjuManifestation)
