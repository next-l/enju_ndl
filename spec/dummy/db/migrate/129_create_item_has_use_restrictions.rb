class CreateItemHasUseRestrictions < ActiveRecord::Migration[5.2]
  def change
    create_table :item_has_use_restrictions do |t|
      t.references :item, foreign_key: true, null: false, type: :uuid
      t.references :use_restriction, foreign_key: true, null: false

      t.timestamps
    end
  end
end
