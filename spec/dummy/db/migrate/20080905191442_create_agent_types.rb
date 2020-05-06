class CreateAgentTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :agent_types do |t|
      t.string :name, null: false
      t.text :note, comment: '備考'
      t.integer :position

      t.timestamps
    end
  end
end
