Rails.application.routes.draw do

  root 'home#index'

  resources :pets do
    collection do
      get :search, to: 'search_pets#index'
    end
  end
end
