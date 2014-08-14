class AddDefaultLibraryIdToEventImportFile < ActiveRecord::Migration
  def change
    add_column :event_import_files, :default_library_id, :integer
  end
end
