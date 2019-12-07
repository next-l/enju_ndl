class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :library, index: true, null: false
      t.references :event_category, index: true, null: false
      t.string :name
      t.text :note
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :all_day, default: false, null: false
      t.text :display_name

      t.timestamps
    end
  end
end
