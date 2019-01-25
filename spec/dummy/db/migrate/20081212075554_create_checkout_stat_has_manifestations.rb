class CreateCheckoutStatHasManifestations < ActiveRecord::Migration[5.2]
  def change
    create_table :checkout_stat_has_manifestations do |t|
      t.references :manifestation_checkout_stat, index: false, null: false
      t.references :manifestation, index: false, foreign_key: true, null: false, type: :uuid
      t.integer :checkouts_count

      t.timestamps
    end
    add_index :checkout_stat_has_manifestations, :manifestation_checkout_stat_id, name: 'index_checkout_stat_has_manifestations_on_checkout_stat_id'
    add_index :checkout_stat_has_manifestations, :manifestation_id, name: 'index_checkout_stat_has_manifestations_on_manifestation_id'
  end
end
