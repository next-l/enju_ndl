class CreateProduces < ActiveRecord::Migration
  def change
    create_table :produces do |t|
      t.integer :manifestation_id
      t.integer :patron_id

      t.timestamps
    end
  end
end
