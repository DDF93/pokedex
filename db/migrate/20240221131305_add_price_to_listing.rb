class AddPriceToListing < ActiveRecord::Migration[7.1]
  def change
    add_column :listings, :price, :float
  end
end
