require "rails_helper"

RSpec.describe ProductsController, type: :request do
  let!(:product) { create(:product) }

  let(:valid_product_params) { { product: attributes_for(:product) } }
  let(:invalid_product_params) { { product: attributes_for(:product, :invalid_product) } }


  describe 'GET #index' do
    it 'returns the products' do
      get products_path

      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a product' do
      get product_path(product)

      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'initializes new product' do
      get new_product_path

      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get edit_product_path(product)

      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new product and redirects to the product page' do
        expect {
          post products_path, params: valid_product_params
        }.to change(Product, :count).by(1)

        expect(response).to redirect_to(product_path(Product.last))
        expect(flash[:notice]).to eq("Product successfully created.")
      end
    end

    context 'with invalid params' do
      it 'renders the new template with unprocessable entity status' do
        post products_path, params: invalid_product_params

        expect(response).to be_unprocessable
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the product and redirects to the product page' do
        patch product_path(product), params: valid_product_params

        expect(product.reload.name).to eq(valid_product_params[:product][:name])
        expect(response).to redirect_to(product)
        expect(flash[:notice]).to eq("Product successfully updated.")
      end
    end

    context 'with invalid params' do
      it 'renders the edit template with unprocessable entity status' do
        patch product_path(product), params: invalid_product_params

        expect(response).to be_unprocessable
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the product and redirects to the products index' do
      expect {
        delete product_path(product)
      }.to change(Product, :count).by(-1)

      expect(response).to redirect_to(products_path)
      expect(flash[:notice]).to eq("Product successfully destroyed.")
    end
  end
end
