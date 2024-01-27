class PetsController < ApplicationController

  def index
    @filter = params[:filter]
    @search = params[:q].presence
    @pets = filtered_pets
    @pets = @pets.search(@search) if @search.present?
    @pets_count = @pets.count
    @pets = @pets.page(params[:page]).per(9)
  end

  def dogs
    @filter = 'dogs'
    @pets = filtered_pets
  end

  def cats
    @filter = 'cats'
    @pets = filtered_pets
  end

  def random
    @pet = Pet.order("random()").first
    redirect_to pet_path(@pet)
  end

  def show
    @pet = Pet.find(params[:id])
    PetView.create(pet_id: @pet.id)
  end

  private

  def filtered_pets
    case @filter
    when "dogs"
      @pets = Pet.dogs
    when "cats"
      @pets = Pet.cats
    when "most_viewed"
      @pets = Pet.most_viewed
    when "recent"
      @pets = Pet.recent
    else
      @pets = Pet.all
    end
  end
end
