class AddIsilToLibrary < ActiveRecord::Migration[5.0]
  def change
    add_column :libraries, :isil, :string
  end
end
