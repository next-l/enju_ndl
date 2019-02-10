class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events, id: :uuid do |t|
      t.references :library, foreign_key: true, null: false, type: :uuid
      t.references :event_category, index: true, null: false
      t.string :name, null: false
      t.text :note
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :all_day, default: false, null: false
      t.jsonb :display_name, default: {}, null: false

      t.timestamps
    end
  end
end
