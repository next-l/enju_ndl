class AddUniqueIndexToManifestationIdentifierOnManifestation < ActiveRecord::Migration[5.2]
  def change
    remove_index :manifestations, :manifestation_identifier
    add_index :manifestations, :manifestation_identifier, unique: true
  end
end
