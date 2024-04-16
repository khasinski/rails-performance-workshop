class GenerateDataJob < ApplicationJob
  self.queue_adapter = :async

  def perform(data_generation_loop_size = 10000)
    data_generation_loop_size.times.each do |i|
      puts "Populating pets #{i+1}/#{data_generation_loop_size}"
      pets = 100.times.map do
        type = Pet.pet_types.keys.sample
        breed = if type == 'dog'
                  Faker::Creature::Dog.breed
                else
                  Faker::Creature::Cat.breed
                end

        timestamp = Faker::Time.between(from: 1.year.ago, to: Date.today)

        adoption_date = nil
        adoption_date = Faker::Time.between(from: timestamp, to: Date.today) if rand(0..10) < 5

        shelter = shelters.sample

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
          shelter_id: shelter.id, # Randomly assign a shelter from existing ones
          latitude: shelter.latitude,
          longitude: shelter.longitude,
        ).attributes.except('id')
      end
      pet_ids = Pet.insert_all(pets, returning: [:id]).rows.flatten

      pet_vaccinations = pet_ids.map do |pet_id|
        vaccination_ids = vaccinations.sample(rand(1..5)).map(&:id)
        vaccination_ids.map do |vaccination_id|
          {
            pet_id: pet_id,
            vaccination_id: vaccination_id,
            vaccination_date: Faker::Date.between(from: '2023-01-01', to: Date.today),
            created_at: Faker::Time.between(from: 1.year.ago, to: Date.today),
            updated_at: Faker::Time.between(from: 1.year.ago, to: Date.today)
          }
        end
      end

      PetVaccination.insert_all(pet_vaccinations.flatten)

      raise "Failed to populate pet_vaccinations" if PetVaccination.count == 0

    end
  end

  private

  def vaccinations
    @vaccinations ||= if Vaccination.count > 0
      Vaccination.all
    else
      9.times.map do |i|
        Vaccination.create!(
          name: "V-040#{i}",
          description: Faker::Lorem.paragraph
        )
      end
    end
  end

  def shelters
    @shelters ||= if Shelter.count > 0
      Shelter.all
    else
      100.times.map do
        location = ANIMAL_SHELTERS.sample[:coordinates].sample
        Shelter.create!(
          name: Faker::Company.name,
          address: Faker::Address.street_address,
          phone: Faker::PhoneNumber.phone_number,
          email: Faker::Internet.email,
          latitude: location[:latitude],
          longitude: location[:longitude],
          )
      end
    end
  end
end
