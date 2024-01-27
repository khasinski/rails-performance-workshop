Rails.application.routes.draw do

  root 'home#index'

  resources :dogs, to: 'pets#dogs', only: [:index]
  resources :cats, to: 'pets#cats', only: [:index]

  resources :pets, only: [:index, :show] do
    collection do
      get :random, to: 'pets#random'
    end
  end
end
