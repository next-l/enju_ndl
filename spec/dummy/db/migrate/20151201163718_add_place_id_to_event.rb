class AddPlaceIdToEvent < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :place, index: true
  end
end
