class ProductsController < ApplicationController
  def index
    @products = collection.order(:name)
  end

  def show
    @product = resourse
  end

  def new
    @product = Product.new
  end

  def edit
    @product = resourse
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: "Product successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product = resourse

    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = resourse

    @product.destroy
    redirect_to products_url, notice: "Product successfully destroyed."
  end

  def buy
    session[:products] = {} unless session[:products]
    new_product = Products::Buy.new(params:).call

    session[:products] = Session.new(session).add_product(new_product)

    redirect_to products_path, notice: "Product added to cart."
  end

  def cancel_shipping
    session[:products] = Session.new(session).delete_product(params[:id])
    session.delete(:products) if session[:products].empty?

    redirect_to orders_path
  end

  private

  def collection
    Product.all
  end

  def resourse
    collection.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :balance)
  end
end
