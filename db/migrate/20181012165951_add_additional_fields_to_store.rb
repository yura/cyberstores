class AddAdditionalFieldsToStore < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :short_description, :string
    add_column :stores, :phone, :string
    add_column :stores, :address, :string
  end
end
