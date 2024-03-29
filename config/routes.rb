Rails.application.routes.draw do

  root "wordly#index"

  get "/wordly", to: "wordly#index"
  get "/check_word", to: "check_word#index"

  get "/logout", to: "users#destroy"
  get "/games", to: "games#index"

  resources :users do
    resources :games
  end

  #get "/users", to: "users#index"
  #post "/users", to: "users#create"
  #delete "/users", to: "users#destroy"

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
