FactoryBot.define do
  factory :pet do
    pet_type { Pet.pet_types.keys.sample }
    name { Faker::Creature::Dog.name }
    breed { Faker::Creature::Dog.breed }
    age { Faker::Number.between(from: 1, to: 20) }
    weight { Faker::Number.between(from: 1, to: 100) }
    color { Faker::Color.color_name }
    shelter { create(:shelter) }
    latitude { shelter.latitude }
    longitude { shelter.longitude }
  end
end
