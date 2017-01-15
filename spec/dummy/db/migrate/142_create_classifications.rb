class CreateClassifications < ActiveRecord::Migration
  def change
    create_table :classifications, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.integer :parent_id, index: true
      t.string :category, null: false, index: true
      t.text :note
      t.integer :classification_type_id, null: false, index: true

      t.timestamps
    end
  end
end
