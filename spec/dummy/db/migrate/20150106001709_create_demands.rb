class CreateDemands < ActiveRecord::Migration[5.2]
  def change
    create_table :demands do |t|
      t.references :user, foreign_key: true
      t.references :item, foreign_key: true, type: :uuid
      t.references :message, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
