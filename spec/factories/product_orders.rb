FactoryBot.define do
  factory :product_order do
    product { nil }
    order { nil }
    amount { Faker::Number.between(from: 1, to: 10) }
  end
end
