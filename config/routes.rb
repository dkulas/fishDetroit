Rails.application.routes.draw do
  # Define the root path route ("/")
  root to: "application#index"

  # User routes
  resources :users, only: [:new, :create, :show] # Ensures users have routes for new, create, and show
  get "/signup", to: "users#new", as: :signup   # Route for signup page

  # Session routes
  get "/login", to: "sessions#new", as: :login
  post "/sessions", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  # Routes for Posts and Comments
  resources :posts do
    resources :comments, only: [:index, :show] # Nested route to show comments on a post
  end

  resources :comments
end
