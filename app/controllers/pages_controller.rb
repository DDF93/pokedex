class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :contact]

  def home
    @best_sellers = Card.where(id: [25, 6, 9, 3, 131, 143, 130, 149, 150, 151, 94, 89, 91, 92, 95, 59, 65, 62, 94, 89, 91, 92, 95, 59, 65])
    @original_cards = Card.where(id: [16688, 4670, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598])
  end

end
