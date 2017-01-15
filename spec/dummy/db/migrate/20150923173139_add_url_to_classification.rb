class AddUrlToClassification < ActiveRecord::Migration
  def change
    add_column :classifications, :url, :string
  end
end
