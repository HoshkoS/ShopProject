FactoryBot.define do
  factory :product do
    name { Faker::Device.model_name }
    description { Faker::Lorem.sentence(word_count: 2) }
    price { Faker::Number.decimal(l_digits: 2) }
    balance { Faker::Number.between(from: 1, to: 10) }
  end
end
