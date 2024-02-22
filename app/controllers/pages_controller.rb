class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @best_sellers = Card.where(id: [10, 20, 30, 40, 50, 60, 70, 80, 90, 100])
    @best_bargains = Card.where(id: [15, 25, 35, 45, 55, 65, 75, 85, 95, 105])
  end

end
