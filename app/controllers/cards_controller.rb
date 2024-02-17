class CardsController < ApplicationController
  def index
    @cards = Card.order("RANDOM()").limit(50)
  end

  def show
    @card = Card.find(params[:id])
  end
end
