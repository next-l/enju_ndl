class Create < ActiveRecord::Base
  belongs_to :work, :class_name => 'Manifestation', :foreign_key => 'work_id'
  belongs_to :patron
end
