class CreateSubjectTypes < ActiveRecord::Migration[4.2]
  def self.up
    create_table :subject_types do |t|
      t.string :name, null: false
      t.text :display_name
      t.text :note
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :subject_types
  end
end
