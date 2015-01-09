class CreateEventCategories < ActiveRecord::Migration
  def self.up
    create_table :event_categories do |t|
      t.string :name, :null => false
      t.text :display_name
      t.text :note
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :event_categories
  end
end
