class Produce < ActiveRecord::Base
  belongs_to :manifestation
  belongs_to :patron
end
