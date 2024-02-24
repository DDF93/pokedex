class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :card
  has_one :sale
end
