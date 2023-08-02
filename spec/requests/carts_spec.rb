require 'rails_helper'

RSpec.describe CartsController, type: :request do
  let!(:product) { create(:product) }

  describe "GET /cart" do
    it "redirects back to products page when the cart is empty" do
      get cart_path

      expect(response).to redirect_to(products_path)
      expect(flash[:notice]).to eq("Your cart is empty yet")
    end

    it "renders the cart page with product" do
      patch add_product_in_cart_path(product)

      get cart_path

      expect(response).to be_successful
      expect(response.body).to include(product.name)
    end
  end

  describe "PATCH #add" do
    it "adds the product to the cart and redirects back to the previous page" do
      patch add_product_in_cart_path(product), headers: { 'HTTP_REFERER' => products_path }

      expect(session.dig(:products)).to include(product.id.to_s)
      expect(response).to redirect_to(products_path)
    end
  end

  describe "PATCH #change_amount" do
    let(:amount) { 2 }

    it "changes the product amount in the cart and redirects back to the previous page" do
      patch change_amount_product_in_cart_path(product), params: { amount: }, headers: { 'HTTP_REFERER' => cart_path }

      expect(session.dig(:products)).to include(product.id.to_s => amount)
      expect(response).to redirect_to(cart_path)
    end
  end

  describe "PATCH #remove" do
    it "removes the product from the cart and redirects back to the previous page" do
      patch remove_product_in_cart_path(product), headers: { 'HTTP_REFERER' => cart_path }

      expect(session[:products]).to be_nil
      expect(response).to redirect_to(cart_path)
    end
  end

  describe "DELETE #destroy" do
    it "clears the cart and redirects to the products page" do
      delete cart_path(1)

      expect(session[:products]).to be_nil
      expect(response).to redirect_to(products_path)
    end
  end
end
