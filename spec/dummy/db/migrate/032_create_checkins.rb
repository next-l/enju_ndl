class CreateCheckins < ActiveRecord::Migration[5.2]
  def change
    create_table :checkins, id: :uuid do |t|
      t.references :librarian, index: true
      t.references :basket, index: true, type: :uuid
      t.timestamps
    end
  end
end
