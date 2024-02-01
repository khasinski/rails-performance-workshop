require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validations" do
    it "requires a name" do
      pet = Pet.new
      pet.valid?
      expect(pet.errors.messages).to have_key(:name)
    end

    it "requires an age" do
      pet = Pet.new
      pet.valid?
      expect(pet.errors.messages).to have_key(:age)
    end

    it "requires a breed" do
      pet = Pet.new
      pet.valid?
      expect(pet.errors.messages).to have_key(:breed)
    end

    it "requires a color" do
      pet = Pet.new
      pet.valid?
      expect(pet.errors.messages).to have_key(:color)
    end

    it "requires a weight" do
      pet = Pet.new
      pet.valid?
      expect(pet.errors.messages).to have_key(:weight)
    end

    it "requires a weight greater than 0" do
      pet = Pet.new(weight: 0)
      pet.valid?
      expect(pet.errors.messages).to have_key(:weight)
    end
  end

  describe "methods" do
    describe "#image_url" do
      it "returns a dog image url for dogs" do
        pet = Pet.new(pet_type: "dog")
        expect(pet.image_url).to include("https://placedog.net")
      end

      it "returns a cat image url for cats" do
        pet = Pet.new(pet_type: "cat")
        expect(pet.image_url).to include("https://placekitten.com")
      end
    end

    describe "#tagline" do
      it "returns a dog tagline for dogs" do
        pet = Pet.new(pet_type: "dog", name: "Fido", age: 5, breed: "Golden Retriever")
        expect(pet.tagline).to eq("Fido is a 5 year old Golden Retriever looking for a home!")
      end

      it "returns a cat fact for cats" do
        allow(Net::HTTP).to receive(:get).and_return('{"fact": "Cats are cool"}')
        pet = Pet.new(pet_type: "cat")
        expect(pet.tagline).to eq("Cats are cool")
      end
    end
  end

  describe "scopes" do
    it "returns recent pets" do
      pet1 = create(:pet, name: "Fido", created_at: 1.day.ago)
      pet2 = create(:pet, name: "Fido")
      expect(Pet.recent).to eq([pet2, pet1])
    end

    it "returns available pets" do
      _pet1 = create(:pet, name: "Fido", adoption_date: 1.day.ago)
      pet2 = create(:pet, name: "Fido")
      expect(Pet.available).to eq([pet2])
    end

    it "returns pets that match a search" do
      pet1 = create(:pet, name: "Fido")
      _pet2 = create(:pet, name: "Spot")
      expect(Pet.search("Fido")).to eq([pet1])
    end

    it "returns dogs" do
      pet1 = create(:pet, name: "Fido", pet_type: "dog")
      _pet2 = create(:pet, name: "Spot", pet_type: "cat")
      expect(Pet.dogs).to eq([pet1])
    end

    it "returns cats" do
      _pet1 = create(:pet, name: "Fido", pet_type: "dog")
      pet2 = create(:pet, name: "Spot", pet_type: "cat")
      expect(Pet.cats).to eq([pet2])
    end

    it "returns pets similar to the current pet" do
      pet1 = create(:pet, name: "Fido", pet_type: "dog")
      pet2 = create(:pet, name: "Spot", pet_type: "dog")
      expect(pet1.similar_type_pets).to eq([pet2])
    end

    it "returns pets with similar names to the current pet" do
      pet1 = create(:pet, name: "Fido", breed: "Golden Retriever", pet_type: "dog")
      pet2 = create(:pet, name: "Fido", breed: "Labrador", pet_type: "cat")
      expect(pet1.similiar_name_pets).to eq([pet2])
    end

    it "returns most viewed pets" do
      pet1 = create(:pet, name: "Fido")
      pet2 = create(:pet, name: "Spot")
      pet3 = create(:pet, name: "Rover")
      PetView.create!(pet: pet1)
      PetView.create!(pet: pet1)
      PetView.create!(pet: pet2)

      expect(Pet.most_viewed).to eq([pet1, pet2, pet3])
    end

    it "returns pets near a city" do
      pet1 = create(:pet, name: "Fido", shelter: create(:shelter, latitude: 52.2315, longitude: 21.0068))
      pet2 = create(:pet, name: "Spot", shelter: create(:shelter, latitude: 52.2303, longitude: 21.0205))
      pet3 = create(:pet, name: "Rover", shelter: create(:shelter, latitude: 52.2392, longitude: 21.0121))

      expect(Pet.by_city("Warsaw", 1)).to contain_exactly(pet1, pet2, pet3)
    end
  end
end
