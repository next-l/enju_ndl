class AddDefaultLibraryIdToEventImportFile < ActiveRecord::Migration[5.2]
  def change
    add_reference :event_import_files, :default_library
  end
end
