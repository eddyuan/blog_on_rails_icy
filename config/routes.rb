Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/', to: 'posts#index', as: :root

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

end
