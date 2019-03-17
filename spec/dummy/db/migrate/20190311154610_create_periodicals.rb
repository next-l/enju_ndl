class CreatePeriodicals < ActiveRecord::Migration[5.2]
  def change
    create_table :periodicals, id: :uuid do |t|
      t.text :original_title, null: false
      t.references :frequency, foreign_key: true, null: false

      t.timestamps
    end
  end
end
