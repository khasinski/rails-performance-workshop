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
end
