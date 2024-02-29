class Listing < ApplicationRecord
  attr_accessor :post_code, :city, :state, :phone_number
  belongs_to :user
  belongs_to :card
  has_one :sale
end
