Rails.application.routes.draw do

  root 'home#index'

  resources :dogs, to: 'pets#dogs', only: [:index]
  resources :cats, to: 'pets#cats', only: [:index]

  resources :pets, only: [:index, :show] do
    collection do
      get :search, to: 'search_pets#index'
      get :random, to: 'pets#random'
    end
  end
end
