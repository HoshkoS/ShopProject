require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:phone) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:products).through(:product_orders) }
    it { is_expected.to have_many(:product_orders).dependent(:destroy) }
  end
end
