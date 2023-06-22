Rails.application.routes.draw do
  root "products#index"

  resources :products, only: [:index, :show] do
    member do
      post :buy, to: "carts#update", as: "buy"
      post :change_amount, to: "carts#update", as: "change_amount"
      post :cancel_delivery, to: "carts#update", as: "cancel_delivery"
    end
  end

  get "cart", to: "carts#show", as: 'cart'
  delete "clean_cart", to: "carts#destroy", as: "clean_cart"

  resources :orders
  resources :products
end
