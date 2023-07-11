Rails.application.routes.draw do
  devise_for :users
  root "products#index"

  resources :products do
    member do
      resource :cart, only: [] do
        [:add, :remove, :change_amount].each do |action|
          patch action, to: "carts#update", as: "#{action}_product_in", defaults: { update_action: action.to_s }
        end
      end
    end
  end

  resource :cart
  resources :orders
end
