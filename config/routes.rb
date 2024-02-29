Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"
  get 'contact', to: 'pages#contact'
  get "up" => "rails/health#show", as: :rails_health_check
  get '/my_purchases', to: 'listings#my_purchases'
  get '/items_for_sale', to: 'listings#items_for_sale'
  get '/sold_items', to: 'listings#sold_items'

  resources :cards, only: [:index, :show] do
    resources :listings, only: [:new, :create, :show, :edit, :update]
  end

  resources :listings, only: [:show, :update, :destroy] do
    collection do
      get 'transactions'
    end
  end
end
