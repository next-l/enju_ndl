class CreateDoiRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :doi_records, comment: 'DOI' do |t|
      t.string :body, index: {unique: true}, null: false, comment: '正規化名'
      t.string :display_body, null: false, comment: '表示名'
      t.string :source, source: 'APIレスポンス取得元'
      t.jsonb :response, default: {}, null: false, source: 'APIレスポンス'
      t.references :manifestation, foreign_key: true, null: false

      t.timestamps
    end
  end
end
