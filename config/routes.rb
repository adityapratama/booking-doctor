Rails.application.routes.draw do
  root 'pages#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'hospitals/:slug', to: 'pages#show'
  get 'hospitals/:hospital_slug/doctors/:slug', to: 'pages#doctor'
  get 'auth/:provider/callback', to: 'sessions#callback'
  get 'auth/failure', to: redirect('/')

  resources :pages do
    collection do
      resources :bookings do
        collection do
          get 'my', to: 'pages#my_bookings'
        end
      end
    end
  end
  namespace :admin do
    resources :users
    resources :hospitals do
      resources :doctors do
        resources :schedules
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
