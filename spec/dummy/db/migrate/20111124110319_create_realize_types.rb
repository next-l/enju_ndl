class CreateRealizeTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :realize_types do |t|
      t.string :name
      t.text :note, comment: '備考'
      t.integer :position

      t.timestamps
    end
  end
end
