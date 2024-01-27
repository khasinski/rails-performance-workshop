class PetsController < ApplicationController

  def index
    @filter = params[:filter] || "all_pets"
    @search = params[:q].presence
    @pets = Pet.all
    @pets = @pets.where("name ILIKE ?", "%#{@search}%") if @search.present?
    @pets = @pets.order("created_at DESC")
    @pets_count = @pets.count
    @pets = @pets.page(params[:page]).per(9)
  end

  def show
    @pet = Pet.find(params[:id])
    PetView.create(pet_id: @pet.id)
  end
end
