FactoryBot.define do
  factory :order do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    address { Faker::Address.street_address }
    phone { Faker::PhoneNumber.cell_phone_in_e164 }
  end

  trait :invalid_order do
    first_name { nil }
    last_name { nil }
    address { nil }
    phone { nil }
  end
end
