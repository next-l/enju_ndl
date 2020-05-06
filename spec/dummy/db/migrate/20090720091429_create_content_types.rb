class CreateContentTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :content_types do |t|
      t.string :name, null: false
      t.text :note, comment: '備考'
      t.integer :position

      t.timestamps
    end
  end
end
