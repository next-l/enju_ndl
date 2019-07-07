class AddDefaultLibraryIdToEventImportFile < ActiveRecord::Migration[4.2]
  def change
    add_column :event_import_files, :default_library_id, :integer
  end
end
