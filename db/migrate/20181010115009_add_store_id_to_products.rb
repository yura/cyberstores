class AddStoreIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :store, index: true
  end
end
