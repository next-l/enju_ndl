class AddUrlToSubject < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :url, :string
  end
end
