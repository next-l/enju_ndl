class CreateCheckins < ActiveRecord::Migration[5.2]
  def change
    create_table :checkins do |t|
      t.references :librarian, index: true
      t.references :basket, index: true
      t.timestamps
    end
  end
end
