require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users,
    controllers: {
      confirmations: 'confirmations',
      passwords: 'passwords',
      registrations: 'registrations', 
      sessions: 'sessions'
    }

#devise_scope :user do 
 # get '/users/sign-in', to: 'users/sessions#create'

#end

  # Ping to ensure site is up
  resources :ping, only: [:index] do
    collection do
      get :auth
    end
  end

  # APIs
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :update] do
        collection do
          get :available
        end
      end
    end
  end
end
