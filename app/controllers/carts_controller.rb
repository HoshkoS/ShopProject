class CartsController < ApplicationController
  before_action :init_cart, only: :update
  before_action :check_cart, only: :show

  def show
    @cart = Cart::ManagerService.new(session, cart_params)
  end

  def update
    Cart::ManagerService.new(session, params).handle_update

    redirect_back fallback_location: root_path, notice: "Product #{params[:update_action].sub('_', ' ')} in cart"
  end

  def destroy
    session.delete(:products)

    redirect_to products_path, notice: "Cart was cleaned"
  end

  private

  def init_cart
    session[:products] = {} if session[:products].blank?
  end

  def check_cart
    redirect_to products_path, notice: "Your cart is empty yet" if session[:products].blank?
  end

  def cart_params
    params.permit(:id, :amount, :update_action)
  end
end
