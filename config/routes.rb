Rails.application.routes.draw do
  # Define the root path route ("/")
  root to: "application#index"

  # User routes
  resources :users, only: [:new, :create, :show, :edit, :update] do
    resources :posts, only: [:create] # Nest posts under users to allow user-specific post creation
    member do 
      patch :update_password
    end
  end
  delete '/users/:id', to: 'users#destroy', as: 'delete_user'

  get "/signup", to: "users#new", as: :signup   # Route for signup page

  # Session routes
  get "/login", to: "sessions#new", as: :login
  post "/sessions", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  # Routes for standalone Posts and Comments
  resources :posts, only: [:index, :show, :edit, :update, :destroy] # Other post actions not tied to user
  resources :comments
end
