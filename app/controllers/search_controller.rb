class SearchController < ApplicationController
  def index
    pets = Pet.where("name ILIKE ?", "#{params[:query]}%")

    render json: {
      pets: pets.take(10).map { |pet| { id: pet.id, name: pet.name, link: pet_path(pet) } },
      matching_pets_count: pets.count
    }
  end
end
