class AddUrlToLicense < ActiveRecord::Migration[6.0]
  def change
    add_column :licenses, :url, :string, index: {unique: true}
  end
end
