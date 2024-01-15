namespace :generate do
  task :data => :environment do |t, args|
    Pet.delete_all
    Shelter.delete_all
    Vaccination.delete_all

    shelters = 100.times.map do
      Shelter.create!(
        name: Faker::Company.name,
        address: Faker::Address.street_address,
        phone: Faker::PhoneNumber.phone_number,
        email: Faker::Internet.email
      )
    end

    vaccinations = 10.times.map do
      Vaccination.create!(
        name: Faker::Creature::Dog.breed,
        description: Faker::Lorem.paragraph
      )
    end

    100.times.map do |i|
      puts "Populating pets #{i+1}/100"
      pets = 10000.times.map do
        type = Pet.pet_types.keys.sample
        breed = if type == 'dog'
          Faker::Creature::Dog.breed
        else
          Faker::Creature::Cat.breed
        end

        timestamp = Faker::Time.between(from: 1.year.ago, to: Date.today)

        adoption_date = nil
        adoption_date = Faker::Time.between(from: timestamp, to: Date.today) if rand(0..10) < 5

        Pet.new(
          created_at: timestamp,
          updated_at: timestamp,
          name: [Faker::Creature::Dog.name, Faker::Creature::Cat.name].join(' '),
          age: rand(0..15),
          breed: breed,
          color: Faker::Color.color_name,
          weight: rand(5..45),
          pet_type: type,
          gender: Pet.genders.keys.sample,
          size: Pet.sizes.keys.sample,
          microchip_number: Faker::Number.number(digits: 15),
          neutered: [true, false].sample,
          house_trained: [true, false].sample,
          special_needs: [true, false].sample,
          suitable_for_apartments: [true, false].sample,
          good_with_kids: [true, false].sample,
          good_with_other_pets: [true, false].sample,
          activity_level: ['Low', 'Medium', 'High'].sample,
          personality_traits: Faker::Lorem.sentence(word_count: 5),
          medical_conditions: Faker::Lorem.sentence(word_count: 5),
          allergies: Faker::Lorem.sentence(word_count: 5),
          description: Faker::Lorem.paragraph(sentence_count: 3),
          biography: Faker::Lorem.paragraph(sentence_count: 5),
          date_of_birth: Faker::Date.between(from: '2008-01-01', to: '2023-01-01'),
          arrival_date: Faker::Date.between(from: '2023-01-01', to: Date.today),
          adoption_date: adoption_date, # Assuming the pet is not yet adopted
          shelter_id: shelters.sample.id # Randomly assign a shelter from existing ones
        ).attributes.except('id')
      end
      Pet.insert_all(pets)
    end
  end
end
