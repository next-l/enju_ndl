class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :user_group_id
      t.integer :required_role_id
      t.string :username
      t.text :note
      t.string :locale

      t.timestamps
    end
  end
end
