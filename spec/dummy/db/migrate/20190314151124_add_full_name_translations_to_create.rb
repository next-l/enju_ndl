class AddFullNameTranslationsToCreate < ActiveRecord::Migration[5.2]
  def change
    add_column :creates, :full_name_translations, :jsonb, default: {}
    add_column :realizes, :full_name_translations, :jsonb, default: {}
    add_column :produces, :full_name_translations, :jsonb, default: {}
  end
end
