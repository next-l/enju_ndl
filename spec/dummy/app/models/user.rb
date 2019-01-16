class User < ActiveRecord::Base
  devise :database_authenticatable, #:registerable,
    :recoverable, :rememberable, :trackable, #, :validatable
    :lockable, :lock_strategy => :none, :unlock_strategy => :none

  include EnjuSeed::EnjuUser
end

Manifestation.include(EnjuSubject::EnjuManifestation)
ImportRequest.include(EnjuNdl::EnjuManifestation)
Manifestation.include(EnjuNdl::EnjuManifestation)
Agent.include(EnjuNdl::EnjuAgent)
Question.include(EnjuNdl::EnjuQuestion)
