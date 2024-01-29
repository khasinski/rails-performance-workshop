class PetsController < ApplicationController

  def index
    @filter = params[:filter]
    @search = params[:q].presence
    @pets = filtered_pets
    @pets = @pets.search(@search) if @search.present?
    @pets_count = @pets.count
    @pets = @pets.page(params[:page]).per(9)
    respond_to do |format|

      format.html { render :index }
      format.json do
        render json: {
          pets: @pets.map { |pet| { id: pet.id, name: pet.name, link: pet_path(pet), breed: pet.breed } },
          matching_pets_count: @pets_count
        }
      end
    end
  end

  def dogs
    @filter = 'dogs'
    @pets = filtered_pets.page(params[:page]).per(9)
    @pets_count = @pets.total_count
  end

  def cats
    @filter = 'cats'
    @pets = filtered_pets.page(params[:page]).per(9)
    @pets_count = @pets.total_count
  end

  def random
    @pet = Pet.order("random()").first
    redirect_to pet_path(@pet)
  end

  def show
    @pet = Pet.find(params[:id])
    @extra_info =
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
