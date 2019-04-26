class AddLibraryIdToCheckout < ActiveRecord::Migration[5.2]
  def change
    add_reference :checkouts, :library, foreign_key: true
  end
end
