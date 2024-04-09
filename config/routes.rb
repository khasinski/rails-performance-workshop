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

  # PgHero routes, use them to figure out long running queries
  mount PgHero::Engine, at: "pghero"

  # Workshop helper routes, pretend they are not here
  post '/workshop/generate_data', to: -> (env) do
    GenerateDataJob.perform_later(
      (env['rack.request.form_hash']['data_generation_loop_size'] || 100).to_i
    )
    [303, { 'Location' => '/' }, ['Redirecting...']]
  end

  namespace :mock do
    get '/slow-service', to: '/mock#slow_service'
    get '/outlier/:id', to: '/mock#outlier'
  end
end
