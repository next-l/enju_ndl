class AddUrlToClassification < ActiveRecord::Migration[5.0]
  def change
    add_column :classifications, :url, :string
  end
end
