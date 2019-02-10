class CreateEventImportFileTransitions < ActiveRecord::Migration[5.2]
  def change
    create_table :event_import_file_transitions do |t|
      t.string :to_state
      t.jsonb :metadata, default: {}
      t.integer :sort_key
      t.references :event_import_file
      t.timestamps
    end

    add_index :event_import_file_transitions, [:sort_key, :event_import_file_id], unique: true, name: "index_event_import_file_transitions_on_sort_key_and_file_id"
  end
end
