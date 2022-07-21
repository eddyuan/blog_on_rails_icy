Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/', to: 'posts#index', as: :root

  # /posts/1
  resources :posts do
    # /posts/1/comments/2
    resources :comments, only: [:create, :destroy]
  end

end
