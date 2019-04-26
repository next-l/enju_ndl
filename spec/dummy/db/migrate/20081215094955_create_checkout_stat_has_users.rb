class CreateCheckoutStatHasUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :checkout_stat_has_users do |t|
      t.references :user_checkout_stat, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.integer :checkouts_count, default: 0, null: false

      t.timestamps
    end
  end
end
