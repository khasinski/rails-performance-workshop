FactoryBot.define do
  factory :pet do
    name { Faker::Creature::Dog.name }
    breed { Faker::Creature::Dog.breed }
    age { Faker::Number.between(from: 1, to: 20) }
    weight { Faker::Number.between(from: 1, to: 100) }
    color { Faker::Color.color_name }
    shelter { create(:shelter) }
  end
end
