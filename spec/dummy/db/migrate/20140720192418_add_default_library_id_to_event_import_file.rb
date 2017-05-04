class AddDefaultLibraryIdToEventImportFile < ActiveRecord::Migration[5.0]
  def change
    add_column :event_import_files, :default_library_id, :integer
  end
end
