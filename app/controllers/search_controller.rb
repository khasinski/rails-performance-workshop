class SearchController < ApplicationController
  def index
    @pets = Pet.where(search_params)
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def search_params
    params.permit(
      Pet.new.attributes.except(:id).keys
    )
  end
end
