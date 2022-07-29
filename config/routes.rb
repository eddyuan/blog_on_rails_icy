Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "posts#index"

  get "/", to: "posts#index", as: :root

  # Get request return the form
  get "change_password", to: "users#change_password" #, as: :change_password

  # Post request for update
  post "change_password", to: "users#update_password" #, as: :change_password
  patch "change_password", to: "users#update_password" #, as: :change_password
  put "change_password", to: "users#update_password" #, as: :change_password

  # We want a login/logout path instead of session
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # /posts/*
  resources :posts do
    # /posts/*/comments/*
    resources :comments, only: %i[create destroy]
  end

  # /users/
  resources :users, only: %i[new create edit update]

  # /session
  # resource :session, only: %i[new create destroy]
end
