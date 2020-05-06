class CreateAgentMergeLists < ActiveRecord::Migration[5.2]
  def change
    create_table :agent_merge_lists do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
