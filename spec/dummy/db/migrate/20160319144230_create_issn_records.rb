class CreateIssnRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :issn_records, comment: 'ISSN' do |t|
      t.string :body, index: {unique: true}, null: false, comment: 'ISSN'
      t.string :issn_type, comment: 'ISSNの種類'
      t.string :source, comment: '情報源'

      t.timestamps
    end
  end
end
