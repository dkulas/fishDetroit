Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "application#index"

  resources :users, only: [:create, :show]
  get "/signup", to: "users#new"
  get "login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"

  # Routes for Users
  resources :users do
    resources :posts, only: [:index, :show] # Nested route to show a user's posts
    resources :comments, only: [:index, :show] # Nested route to show a user's comments
  end

  # Routes for Posts
  resources :posts do
    resources :comments, only: [:index, :show] # Nested route to show comments on a post
  end

  # Routes for Comments (if needed)
  resources :comments
end
