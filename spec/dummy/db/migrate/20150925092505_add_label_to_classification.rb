class AddLabelToClassification < ActiveRecord::Migration
  def change
    add_column :classifications, :label, :string
  end
end
