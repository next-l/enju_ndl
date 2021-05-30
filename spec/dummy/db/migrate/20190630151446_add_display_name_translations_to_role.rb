class AddDisplayNameTranslationsToRole < ActiveRecord::Migration[5.2]
  def change
    rename_column :roles, :display_name, :old_display_name
    add_column :roles, :display_name_translations, :jsonb, default: {}, null: false
  end
end
