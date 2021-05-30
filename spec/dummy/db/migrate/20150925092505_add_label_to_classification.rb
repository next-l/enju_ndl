class AddLabelToClassification < ActiveRecord::Migration[5.2]
  def change
    add_column :classifications, :label, :string
  end
end
