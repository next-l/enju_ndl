class AddDefaultEventCategoryIdToEventImportFile < ActiveRecord::Migration[4.2]
  def change
    add_column :event_import_files, :default_event_category_id, :integer
  end
end
