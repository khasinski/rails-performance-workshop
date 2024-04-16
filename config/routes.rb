Rails.application.routes.draw do
  root 'home#index'

  resources :dogs, to: 'pets#dogs', only: [:index]
  resources :cats, to: 'pets#cats', only: [:index]

  resources :pets, only: [:index, :show] do
    collection do
      get :random, to: 'pets#random'
    end
  end

  # Admin routes, no traffic goes here, but there are some slow queries
  namespace :admin, layout: 'admin' do
    root to: redirect('/admin/pets')
    resources :pets, only: [:index]
  end

  # PgHero routes, use them to figure out long running queries
  mount PgHero::Engine, at: "pghero"

  # Mock routes, use them to simulate slow services
  namespace :mock do
    get '/slow-service', to: '/mock#slow_service'
    get '/outlier/:id', to: '/mock#outlier'
  end
end
