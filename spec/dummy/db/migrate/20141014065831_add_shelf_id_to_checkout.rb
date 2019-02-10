class AddShelfIdToCheckout < ActiveRecord::Migration[5.2]
  def change
    add_reference :checkouts, :shelf, foreign_key: true, type: :uuid
  end
end
