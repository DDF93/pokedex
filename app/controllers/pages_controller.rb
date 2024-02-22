class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @cards = Card.where(id: [1, 2, 3])
  end
  
end
