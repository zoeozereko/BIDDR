Rails.application.routes.draw do

  devise_for :users
  
  root "auctions#index"

  resources :auctions do
    resources :bids
  end

end
