class CreateResourceImportFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :resource_import_files, comment: '書誌情報インポートファイル' do |t|
      t.references :user, foreign_key: true, comment: 'アップロードユーザ'
      t.text :note, comment: '備考'
      t.datetime :executed_at

      t.timestamps
    end
  end
end
