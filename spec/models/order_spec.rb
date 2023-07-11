require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:order) { create(:order) }
  let!(:product) { create(:product) }
  let!(:product_order) { create(:product_order, product: product, order: order, amount: 2) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:phone) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:products).through(:product_orders) }
    it { is_expected.to have_many(:product_orders).dependent(:destroy) }
  end

  describe '#full_name' do
    let(:order) { build(:order, first_name: 'John', last_name: 'Doe') }

    it 'returns the full name' do
      expect(order.full_name).to eq('John Doe')
    end
  end

  describe '#product_sum' do
    it 'returns the sum of product prices for the given product in the order' do
      expect(order.product_sum(product)).to eq(product.price * product_order.amount)
    end
  end

  describe '#product_amount' do
    it 'returns the amount of the given product in the order' do
      expect(order.product_amount(product_order.product)).to eq(product_order.amount)
    end
  end

  describe '#total_sum' do
  let(:expected_sum) { product_order.amount * product.price}

    it 'returns the total sum of product prices in the order' do
      expect(order.total_sum).to eq(expected_sum)
    end
  end
end
