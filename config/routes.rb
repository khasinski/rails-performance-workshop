Rails.application.routes.draw do

  root 'home#index'

  resources :dogs, to: 'pets#dogs', only: [:index]
  resources :cats, to: 'pets#cats', only: [:index]

  resources :pets, only: [:index, :show] do
    collection do
      get :random, to: 'pets#random'
    end
  end

  namespace :admin, layout: 'admin' do
    root to: redirect('/admin/pets')
    resources :pets, only: [:index]
  end
end
