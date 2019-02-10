class AddLibraryIdToCheckout < ActiveRecord::Migration[5.2]
  def change
    add_reference :checkouts, :library, foreign_key: true, type: :uuid
  end
end
