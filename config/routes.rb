Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :questions, only: [:index, :create]

  resources :users
  
  resources :safe_places, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :reviews
  end

  get 'messages/history', to: 'messages#history'
  resources :messages, only: [:index, :new, :show, :create, :update]
  resources :doctors do
    resources :availabilities, only: [:create, :edit, :update]
  end
  resources :mothers, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :feeds
    resources :children, only: [:index, :new, :create]
  end
  resources :children, only: [:destroy]
  resources :dashboards, only: [:index], as: :dashboard


end
