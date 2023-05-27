require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:phone) }
  end

  describe 'associations' do
    it { should have_many(:products) }
    it { should have_many(:product_orders) }
  end
end
