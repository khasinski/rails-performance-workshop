class HomeController < ApplicationController
  def index
    list_size = 4

    
    @pets = {
      recently_added: Pet.all.order(created_at: :desc).limit(list_size),
      most_commented: Pet.all.order(created_at: :desc).limit(list_size), # TODO: add comments
      most_liked: Pet.all.order(created_at: :desc).limit(list_size), # TODO: add likes
      recently_adopted: Pet.all.order(adoption_date: :desc).limit(list_size),
      random: Pet.all.order(Arel.sql('RANDOM()')).limit(list_size),
      most_viewed: Pet.all.most_viewed.limit(list_size),
    }
  end
end
