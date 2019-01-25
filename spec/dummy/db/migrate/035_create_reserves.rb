class CreateReserves < ActiveRecord::Migration[5.2]
  def change
    create_table :reserves do |t|
      t.references :user, foreign_key: true, null: false
      t.references :manifestation, foreign_key: true, null: false, type: :uuid
      t.references :item, foreign_key: true, type: :uuid
      t.references :request_status_type, null: false
      t.datetime :checked_out_at
      t.timestamps
      t.datetime :canceled_at
      t.datetime :expired_at
      t.boolean :expiration_notice_to_patron, default: false
      t.boolean :expiration_notice_to_library, default: false
    end
  end
end
