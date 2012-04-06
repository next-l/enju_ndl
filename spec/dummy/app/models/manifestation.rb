class Manifestation < ActiveRecord::Base
  has_many :creates, :dependent => :destroy, :foreign_key => 'work_id'
  has_many :creators, :through => :creates, :source => :patron
  has_many :produces, :dependent => :destroy, :foreign_key => 'manifestation_id'
  has_many :publishers, :through => :produces, :source => :patron
  has_one :series_has_manifestation, :dependent => :destroy
  has_one :series_statement, :through => :series_has_manifestation
  belongs_to :language
  belongs_to :carrier_type
  belongs_to :manifestation_content_type, :class_name => 'ContentType', :foreign_key => 'content_type_id'
  has_many :work_has_subjects, :foreign_key => 'work_id', :dependent => :destroy
  has_many :subjects, :through => :work_has_subjects

  enju_ndl_search

  searchable do
    text :original_title
  end
end
