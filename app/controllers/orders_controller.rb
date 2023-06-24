class OrdersController < ApplicationController
  before_action :check_cart, only: :new

  def show
    @order = resourse
  end

  def new
    @session_manager = Cart::ManagerService.new(session, params)

    @order = Order.new
  end

  def edit
    @order = resourse
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      Orders::ManagerService.call(session[:products], @order, session)

      redirect_to order_path(@order), notice: "Order was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @order = resourse

    if @order.update(order_params)
      redirect_to @order, notice: "Order was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    resourse.destroy

    redirect_to products_path, notice: "Order successfully destroyed."
  end

  private

  def collection
    Order.all.ordered
  end

  def resourse
    collection.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:first_name, :last_name, :address, :phone)
  end

  def check_cart
    redirect_to products_path unless session[:products].present?
  end
end
