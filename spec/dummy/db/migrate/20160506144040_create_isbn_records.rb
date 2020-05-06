class CreateIsbnRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :isbn_records, comment: 'ISBN' do |t|
      t.string :body, index: {unique: true}, null: false, comment: 'ISBN'
      t.string :isbn_type, comment: 'ISBNの種類'
      t.string :source, comment: '情報源'

      t.timestamps
    end
  end
end
