class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  def new
    @card = Card.find(params[:card_id])
    @listing = @card.listings.build
  end

  def create
    @listing = current_user.listings.new(listing_params)
    @listing.card = Card.find(params[:card_id])
    @listing.price = calculate_listing_price(listing_params[:condition])

    if @listing.save
      redirect_to card_path(@listing.card), notice: 'Listing was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

def update
  if @listing.update(listing_params)
    Sale.create(user_id: current_user.id, listing_id: @listing.id)
    redirect_to cards_path, notice: 'Listing was successfully updated.'
  else
    render :edit
  end
end

def destroy
  @listing = Listing.find(params[:id])
  @listing.destroy
  @my_listings = Listing.where(user_id: current_user.id)
  redirect_to transactions_listings_path
end

def transactions
  @my_listings = Listing.where(user_id: current_user.id)
  @bought_sales = Sale.includes(listing: [:card, :user]).where(user_id: current_user.id)
end


  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:card_id, :delivery_address, :sold, :condition)
  end

  def calculate_listing_price(condition)
    condition_multiplier = case condition
                           when 'Mint'
                             1.0
                           when 'Like new'
                             0.8
                           when 'Used'
                             0.5
                           when 'Poor'
                             0.2
                           else
                             0.0
                           end

    (@listing.card.price * condition_multiplier).round(2)
  end

end
