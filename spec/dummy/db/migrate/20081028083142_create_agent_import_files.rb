class CreateAgentImportFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :agent_import_files, comment: '人物情報インポートファイル' do |t|
      t.references :user, foreign_key: true, comment: 'アップロードユーザ'
      t.text :note, comment: '備考'
      t.datetime :executed_at

      t.timestamps
    end
  end
end
