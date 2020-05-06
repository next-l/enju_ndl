class AddLicenseIdToManifestation < ActiveRecord::Migration[6.0]
  def change
    add_reference :manifestations, :license, null: false, foreign_key: true, default: 1
  end
end
