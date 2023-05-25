require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:phone) }
  end

  describe 'associations' do
    it { should have_many(:products) }
    it { should have_many(:product_orders) }
  end
end
