class CreateUserHasRoles < ActiveRecord::Migration
  def change
    create_table :user_has_roles do |t|
      t.integer :user_id
      t.integer :role_id

      t.timestamps
    end
  end
end
