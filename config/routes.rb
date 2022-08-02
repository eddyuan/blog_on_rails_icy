Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "posts#index"

  get "/", to: "posts#index", as: :root

  # We want a login/logout path instead of session
  get "login", to: "sessions#new" #, as: :login
  post "login", to: "sessions#create" #, as: :login
  patch "login", to: "sessions#create" #, as: :login
  put "login", to: "sessions#create" #, as: :login
  delete "logout", to: "sessions#destroy" #, as: :logout

  # For users, we don't want to see userId in the params, we get user from session instead
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  patch "signup", to: "users#create"
  put "signup", to: "users#create"

  get "user", to: "users#edit" # user_path
  post "user", to: "users#update"
  patch "user", to: "users#update"
  put "user", to: "users#update"

  # For admin
  get "users", to: "users#index" # users_path

  get "change_password", to: "users#change_password" #, as: :change_password
  post "change_password", to: "users#update_password" #, as: :change_password
  patch "change_password", to: "users#update_password" #, as: :change_password
  put "change_password", to: "users#update_password" #, as: :change_password

  # /posts/*
  resources :posts do
    # /posts/*/comments/*
    resources :comments, only: %i[create destroy]
  end
end
