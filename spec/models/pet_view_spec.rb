require 'rails_helper'

RSpec.describe PetView, type: :model do
  it "validates presence of pet" do
    pet_view = PetView.new
    pet_view.valid?
    expect(pet_view.errors.messages).to have_key(:pet)
  end
end
