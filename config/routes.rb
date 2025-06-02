Rails.application.routes.draw do
  get 'safe_places/index'
  get 'safe_places/show'
  get 'safe_places/new'
  get 'safe_places/create'
  get 'reviews/index'
  get 'reviews/show'
  get 'reviews/new'
  get 'reviews/create'
  get 'reviews/edit'
  get 'reviews/update'
  get 'reviews/destroy'
  get 'doctors/index'
  get 'doctors/show'
  get 'doctors/new'
  get 'doctors/create'
  get 'doctors/edit'
  get 'doctors/update'
  get 'doctors/destroy'
  get 'children/index'
  get 'children/new'
  get 'children/create'
  get 'children/destroy'
  get 'feeds/index'
  get 'feeds/show'
  get 'feeds/new'
  get 'feeds/create'
  get 'feeds/edit'
  get 'feeds/update'
  get 'feeds/destroy'

  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :feeds
  resources :users do
    resources :children, only: [:index, :new, :create, :destroy]
  end

  resources :safe_places, only: [:index, :show, :new, :create] do
    resources :reviews
  end

  resources :messages, only: [:index, :new, :show, :create, :update]
  resources :doctors
end
