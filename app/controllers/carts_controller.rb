class CartsController < ApplicationController
  def show
    return unless session[:products]

    @session_products = call_session.products
    @session_sum = call_session.sum
  end

  def create
    session[:products] = {}
  end

  def update
    create unless session[:products].present?

    modify_product

    destroy if session[:products].empty?
  end

  def destroy
    session.delete(:products)

    redirect_to products_path, notice: "Cart was cleaned"
  end

  private

  def modify_product
    case cart_params[:update_action]

    when 'buy'
      call_session.add_product
      redirect_to products_path, notice: "Product added to cart."

    when 'change'
      call_session.set_new_amount
      redirect_to cart_path, notice: "Amount was changed"

    when 'delete'
      call_session.delete_product
      redirect_to cart_path, notice: "Product was removed" if session[:products].present?
    end
  end

  def cart_params
    params.permit(:id, :amount, :update_action)
  end

  def call_session
    Cart::Session.new(session, cart_params)
  end
end
