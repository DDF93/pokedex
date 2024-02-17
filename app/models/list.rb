class List < ApplicationRecord
  belongs_to :card
  belongs_to :seller
  belongs_to :buyer
end
