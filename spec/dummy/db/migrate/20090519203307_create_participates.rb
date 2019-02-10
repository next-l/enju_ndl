class CreateParticipates < ActiveRecord::Migration[5.2]
  def change
    create_table :participates do |t|
      t.references :agent, index: true, null: false, type: :uuid
      t.references :event, foreign_key: true, null: false, type: :uuid
      t.integer :position

      t.timestamps
    end
  end
end
