class CreateIssnRecordAndManifestations < ActiveRecord::Migration[5.2]
  def change
    create_table :issn_record_and_manifestations, comment: '書誌とISSNの関係' do |t|
      t.references :issn_record, foreign_key: true, on_delete: :cascade, null: false
      t.references :manifestation, foreign_key: true, on_delete: :cascade, null: false
      t.integer :position

      t.timestamps
    end
  end
end
