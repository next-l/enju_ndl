class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items, comment: '所蔵' do |t|
      t.string :call_number, comment: '請求記号'
      t.string :item_identifier, comment: '所蔵情報ID'
      t.timestamps
      t.integer :shelf_id, default: 1, null: false, comment: '書架ID'
      t.boolean :include_supplements, default: false, null: false, comment: '付録の有無'
      t.text :note, comment: '備考'
      t.string :url, comment: 'URL'
      t.integer :price, comment: '価格'
      t.integer :lock_version, default: 0, null: false
      t.integer :required_role_id, default: 1, null: false, comment: '参照に必要な権限ID'
      t.integer :required_score, default: 0, null: false
    end
    add_index :items, :shelf_id
    add_index :items, :item_identifier
    add_index :items, :required_role_id
  end
end
