class CreateBudgetTypes < ActiveRecord::Migration
  def change
    create_table :budget_types do |t|
      t.string :name
      t.text :display_name
      t.text :note
      t.integer :position

      t.timestamps
    end
  end
end
