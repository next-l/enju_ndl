class CreateCreates < ActiveRecord::Migration
  def change
    create_table :creates do |t|
      t.integer :work_id
      t.integer :patron_id

      t.timestamps
    end
  end
end
