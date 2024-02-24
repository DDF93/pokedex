class CardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @cards = Card.order("RANDOM()").limit(50)
    if params[:rarity].present? && params[:rarity] != "All"
      @cards = Card.where(rarity: params[:rarity]).limit(50)
    end
    @rarities = Card.where.not(rarity: nil).pluck(:rarity).uniq.sort
  end

  def show
    @card = Card.find(params[:id])
    @cards = Card.order("RANDOM()").limit(6)
    @unsold_listings = @card.listings.reject(&:sold)
  end
end
