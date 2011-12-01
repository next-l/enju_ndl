class Language < ActiveRecord::Base
  has_many :manifestations
  has_many :patrons
end
