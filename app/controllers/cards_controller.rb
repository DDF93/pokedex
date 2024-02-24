class CardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    params[:search] = params[:search].present? ? params[:search] : nil
    @cards = Card.order("RANDOM()").limit(48)

    if params[:search].present?
      @named_cards = Card.where("name ILIKE ?", "%#{params[:search]}%")
      params[:rarity].present? && params[:rarity] != "All" ? @cards = @named_cards.where(rarity: params[:rarity]) : @cards = @named_cards
    end

    if params[:rarity].present? && params[:rarity] != "All" && !params[:search].present?
      @cards = Card.where(rarity: params[:rarity])
    end
    @rarities = Card.where.not(rarity: nil).pluck(:rarity).uniq.sort
  end

  def show
    @card = Card.find(params[:id])
    @cards = Card.order("RANDOM()").limit(6)
    @unsold_listings = @card.listings.reject(&:sold)
  end
end
