class ListingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)

    if @listing.save
      redirect_to listing_path(@listing)
    else
      render :new
    end

    def edit
    end
    
  end

  private

  def listing_params
    params.require(:listing).permit(:card_id)
  end

end
