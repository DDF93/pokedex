class Listing < ApplicationRecord
  belongs_to :card
  belongs_to :seller, class_name: 'User'
end
