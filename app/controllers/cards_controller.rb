class CardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @cards = Card.order("RANDOM()").limit(50)
  end

  def show
    @card = Card.find(params[:id])
    @cards = Card.order("RANDOM()").limit(6)
    @unsold_listings = @card.listings.where(sold: false)
  end
end
