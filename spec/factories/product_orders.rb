FactoryBot.define do
  factory :product_order do
    product
    order
    amount { Faker::Number.between(from: 1, to: 10) }
  end
end
