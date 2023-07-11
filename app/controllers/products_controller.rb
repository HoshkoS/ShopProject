class ProductsController < ApplicationController
  def index
    @products = collection
  end

  def show
    @product = resourse
  end

  private

  def collection
    Product.ordered
  end

  def resourse
    collection.find(params[:id])
  end
end
