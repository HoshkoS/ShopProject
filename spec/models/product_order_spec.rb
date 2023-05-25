require 'rails_helper'

RSpec.describe ProductOrder, type: :model do
  describe "validations" do
    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(1) }
  end

  describe 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:order) }
  end
end
