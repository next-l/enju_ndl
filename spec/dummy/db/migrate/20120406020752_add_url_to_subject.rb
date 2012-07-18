class AddUrlToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :url, :string
  end
end
