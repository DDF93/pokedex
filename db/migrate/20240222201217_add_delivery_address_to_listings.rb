class AddDeliveryAddressToListings < ActiveRecord::Migration[7.1]
  def change
    add_column :listings, :delivery_address, :string
  end
end
