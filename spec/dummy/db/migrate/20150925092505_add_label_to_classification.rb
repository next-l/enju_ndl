class AddLabelToClassification < ActiveRecord::Migration[5.0]
  def change
    add_column :classifications, :label, :string
  end
end
