class CreateNdlaRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :ndla_records do |t|
      t.references :agent, foreign_key: true, type: :uuid
      t.string :body, null: false, index: {unique: true}

      t.timestamps
    end
  end
end
