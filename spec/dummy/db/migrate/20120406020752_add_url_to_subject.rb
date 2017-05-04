class AddUrlToSubject < ActiveRecord::Migration[5.0]
  def change
    add_column :subjects, :url, :string
  end
end
