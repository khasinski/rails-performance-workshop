class PetsController < ApplicationController

  def index
    @filter = params[:filter] || "all_pets"
    @pets = Pet.all.limit(12)
  end

  def show
    @pet = Pet.find(params[:id])
    PetView.create(pet_id: @pet.id)
  end
end
