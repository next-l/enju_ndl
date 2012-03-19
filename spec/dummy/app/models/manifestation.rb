class Manifestation < ActiveRecord::Base
  has_many :creates, :dependent => :destroy, :foreign_key => 'work_id'
  has_many :creators, :through => :creates, :source => :patron
  has_many :produces, :dependent => :destroy, :foreign_key => 'manifestation_id'
  has_many :publishers, :through => :produces, :source => :patron
  has_one :series_has_manifestation, :dependent => :destroy
  has_one :series_statement, :through => :series_has_manifestation
  belongs_to :language
  belongs_to :carrier_type
  belongs_to :content_type

  enju_ndl_search
end
