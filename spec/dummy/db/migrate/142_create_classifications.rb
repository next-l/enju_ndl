class CreateClassifications < ActiveRecord::Migration[5.2]
  def change
    create_table :classifications, comment: '分類' do |t|
      t.integer :parent_id
      t.string :category, null: false
      t.text :note, comment: '備考'
      t.integer :classification_type_id, null: false

      t.timestamps
    end
    add_index :classifications, :parent_id
    add_index :classifications, :category
    add_index :classifications, :classification_type_id
  end
end
