require 'rails_helper'

RSpec.describe OrdersController, type: :request do
  let!(:order) { create(:order) }
  let!(:product) { create(:product) }

  let(:valid_order_params) { { order: attributes_for(:order) } }
  let(:invalid_order_params) { { order: attributes_for(:order, :invalid_order) } }

  describe 'GET #show' do
    it 'returns the order' do
      get order_path(order)

      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response.body).to include(order.id.to_s)
    end
  end

  describe 'GET #new' do
    context 'with empty cart' do
      it 'shows the notice and redirects to products_path' do
        get new_order_path

        expect(response).to redirect_to(products_path)
        expect(flash[:notice]).to eq("Your cart is empty yet")
      end
    end

    context 'with product in cart' do
      it 'sets products and initializes a new order' do
        patch add_product_in_cart_path(product)
        get new_order_path

        expect(response).to be_successful
        expect(response).to render_template(:new)
        expect(response.body).to include("Create your order")
      end
    end
  end

  describe 'POST #create' do
    before do
      patch add_product_in_cart_path(product)
    end

    context 'with valid order params' do
      it 'creates a new order and redirects to order page' do
        expect do
          post orders_path, params: valid_order_params
        end.to change(Order, :count).by(1)

        expect(response).to redirect_to(order_path(Order.last))
        expect(flash[:notice]).to eq("Order was successfully created")
      end
    end

    context 'with invalid order params' do
      it 'renders the new template with unprocessable entity status' do
        post orders_path, params: invalid_order_params

        expect(response).to be_unprocessable
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the order and redirects to the order page' do
        expect do
          patch order_path(order), params: valid_order_params
          order.reload
        end.to change { order.first_name }.to(valid_order_params.dig(:order, :first_name))

        expect(response).to redirect_to(order)
        expect(flash[:notice]).to eq("Order was successfully updated")
      end
    end

    context 'with invalid params' do
      it 'renders the edit template with unprocessable entity status' do
        patch order_path(order), params: invalid_order_params

        expect(response).to be_unprocessable
        expect(response).to render_template(:edit)
      end
    end
  end


  describe 'DELETE #destroy' do
    it 'destroys the order and redirects to the products index' do
      expect do
        delete order_path(order)
      end.to change(Order, :count).by(-1)

      expect(response).to redirect_to(products_path)
      expect(flash[:notice]).to eq("Order successfully destroyed")
    end
  end
end
