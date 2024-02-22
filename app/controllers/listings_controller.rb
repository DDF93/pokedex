class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [:show, :edit, :update]

  def new
    @listing = Listing.new
    @card = Card.find(params[:card_id])
  end

  def create
    @listing = current_user.listings.new(listing_params)

    if @listing.save
      redirect_to listing_path(@listing)
    else
      render :new
    end
  end

  def show
    # This action renders the show view by default
  end

  def edit
    # This action renders the edit view by default
  end

def update
  if @listing.update(listing_params)
    Sale.create(user_id: current_user.id, listing_id: @listing.id)
    redirect_to cards_path, notice: 'Listing was successfully updated.'
  else
    render :edit
  end
end


  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:card_id, :delivery_address, :sold)
  end


end
