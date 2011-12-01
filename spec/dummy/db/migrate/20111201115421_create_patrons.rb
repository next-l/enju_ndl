class CreatePatrons < ActiveRecord::Migration
  def change
    create_table :patrons do |t|
      t.text :full_name
      t.text :full_name_transcription
      t.integer :language_id
      t.integer :required_role_id

      t.timestamps
    end
  end
end
