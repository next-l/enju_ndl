class CreateEventImportFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :event_import_files do |t|
      t.references :parent, index: true
      t.references :user, foreign_key: true
      t.text :note
      t.datetime :imported_at
      t.string :edit_mode

      t.timestamps
    end
  end
end
