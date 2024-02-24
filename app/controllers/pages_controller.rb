class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @best_sellers = Card.where(id: [551, 552, 553, 554, 555, 556, 557, 558, 559, 560])
    @best_bargains = Card.where(id: [110, 120, 130, 140, 150, 160, 170, 180, 190, 200])
  end

end
