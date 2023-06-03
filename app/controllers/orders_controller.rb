class OrdersController < ApplicationController
  def show
    @order = resourse
  end

  def new
    @order = Order.new
  end

  def edit
    @order = resourse
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      create_product_orders
      subtract_balance

      redirect_to order_path(@order), notice: "Order successfully created."
      session[:products] = {}
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @order = resourse

    if @order.update(order_params)
      redirect_to @order, notice: "Order successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order = resourse

    @order.destroy
    redirect_to orders_url, notice: "Order successfully destroyed."
  end

  private

  def collection
    Order.all
  end

  def resourse
    collection.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:first_name, :last_name, :address, :phone)
  end

  def create_product_orders
    session[:products].each { |product_id, amount| @order.product_orders.create(product_id:, amount:) }
  end

  def subtract_balance
    @order.products.each do |product|
      new_balance = product.balance - @order.product_orders.find_by(product_id: product.id).amount
      product.update(balance: new_balance)
    end
  end
end
