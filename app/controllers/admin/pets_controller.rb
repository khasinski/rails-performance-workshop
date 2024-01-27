class Admin::PetsController < ApplicationController
  layout 'admin'
  def index
    @pets = Pet.all
    @pets_total_count = @pets.count
    @pets = @pets.page(params[:page]).per((params[:per_page] || 100).to_i)
  end
end
