class AddDefaultToStores < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :default, :boolean, default: false
  end
end
