class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table "roles" do |t|
      t.column :name, :string, null: false
      t.column :display_name, :string
      t.column :note, :text
      t.integer :score, default: 0, null: false
      t.integer :position

      t.timestamps
    end
  end
end
