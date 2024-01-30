FactoryBot.define do
  factory :shelter do
    name { Faker::Company.name }
    address { Faker::Address.full_address }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
  end
end
