class CreateReserveStatHasUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :reserve_stat_has_users do |t|
      t.references :user_reserve_stat, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.integer :reserves_count

      t.timestamps
    end
  end
end
