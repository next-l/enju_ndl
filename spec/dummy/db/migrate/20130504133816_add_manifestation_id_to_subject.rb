class AddManifestationIdToSubject < ActiveRecord::Migration[5.0]
  def change
    add_column :subjects, :manifestation_id, :integer
    add_index :subjects, :manifestation_id
  end
end
