Rails.application.routes.draw do
  root "products#index"

  resources :products do
    member do
      resource :cart do
        [:add, :remove, :change_amount].each do |action|
          patch action, to: "carts#update", as: "#{action}_product_in"
        end
      end
    end
  end

  get "cart", to: "carts#show", as: 'cart_show'
  delete "clean_cart", to: "carts#destroy", as: "clean_cart"

  resources :orders
end
