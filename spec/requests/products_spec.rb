require "rails_helper"

RSpec.describe ProductsController, type: :request do
  let!(:product) { create(:product) }

  describe 'GET #index' do
    it 'returns the products' do
      get products_path

      expect(response).to be_successful
      expect(response.body).to include("Products")
    end
  end

  describe 'GET #show' do
    it 'returns a product' do
      get product_path(product)

      expect(response).to be_successful
      expect(response.body).to include(product.name)
    end
  end
end
