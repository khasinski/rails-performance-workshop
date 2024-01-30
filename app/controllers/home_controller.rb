class HomeController < ApplicationController
  def index
    list_size = 4

    @pets = {
      recently_added: Pet.recent.limit(list_size),
      recently_adopted: Pet.all.order(adoption_date: :desc).limit(list_size),
      random: Pet.random.limit(list_size),
      most_viewed: Pet.all.most_viewed.limit(list_size),
    }
  end
end
