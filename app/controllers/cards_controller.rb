
class CardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @cards = Card.all

    if params[:search].present?
      @cards = @cards.where("name ILIKE ?", "%#{params[:search]}%")
    end

    if params[:rarity].present? && params[:rarity] != "All"
      @cards = @cards.where(rarity: params[:rarity])
    end

    if params[:min_price].present?
      @cards = @cards.where("price >= ?", params[:min_price].to_f)
    end

    if params[:max_price].present?
      @cards = @cards.where("price <= ?", params[:max_price].to_f)
    end

    if params[:search].blank? && params[:rarity].blank? && params[:min_price].blank? && params[:max_price].blank?
      @cards = @cards.order("RANDOM()").limit(48)
    end

    @cards = @cards.paginate(page: params[:page], per_page: 24)
    @rarities = Card.where.not(rarity: nil).pluck(:rarity).uniq.sort
  end

  def show
    @card = Card.find(params[:id])
    @cards = Card.order("RANDOM()").limit(6)
    @unsold_listings = @card.listings.reject(&:sold)
  end
end
