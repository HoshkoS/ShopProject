Rails.application.routes.draw do
  root "products#index"

  get "cart", to: "carts#show", as: 'cart'
  post "products/:id/buy", to: "carts#update", as: 'buy'
  post "products/:id/change_amount", to: "carts#update", as: 'change_amount'
  post "products/:id/cancel_delivery", to: "carts#update", as:'cancel_delivery'
  delete "clean_cart", to: "carts#destroy", as: "clean_cart"

  resources :orders
  resources :products
end
