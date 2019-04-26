class AddCheckoutIdToCheckin < ActiveRecord::Migration[5.2]
  def change
    add_reference :checkins, :checkout, foreign_key: true, null: false
  end
end
