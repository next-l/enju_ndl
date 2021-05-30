class AddUrlToClassification < ActiveRecord::Migration[5.2]
  def change
    add_column :classifications, :url, :string
  end
end
