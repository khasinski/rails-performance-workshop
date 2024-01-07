class Admin::DashboardController < ApplicationController
  def index
    @total_shelters = Shelter.count
    @top_shelters = Shelter.top_5

    @total_pets = Pet.count
    @total_dogs = Pet.dogs.count
    @total_cats = Pet.cats.count

    @adopted_last_week = Pet.where("adoption_date > ?", 1.week.ago).count
    @adopted_last_month = Pet.where("adoption_date > ?", 1.month.ago).count
    @adopted_last_year = Pet.where("adoption_date > ?", 1.year.ago).count

    @total_applications = AdoptionApplication.count
    @total_applications_last_week = AdoptionApplication.where(created_at: 1.week.ago..).count
    @total_applications_last_month = AdoptionApplication.where(created_at: 1.month.ago..).count
    @total_applications_last_year = AdoptionApplication.where(created_at: 1.year.ago..).count
  end
end
