class CreateEventExportFiles < ActiveRecord::Migration[4.2]
  def change
    create_table :event_export_files do |t|
      t.integer :user_id
      t.attachment :event_export
      t.datetime :executed_at

      t.timestamps
    end
  end
end
