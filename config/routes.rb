Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/", to: "posts#index", as: :root
  # Define the get & post routes for updating passwords for user
  get("/change_password", { to: "users#change_password", as: :change_password })
  patch(
    "/change_password",
    { to: "users#change_password", as: :update_password }
  )
  # /posts/1
  resources :posts do
    # /posts/1/comments/2
    resources :comments, only: %i[create destroy]
  end

  resources :users, only: %i[new create edit update]
end
