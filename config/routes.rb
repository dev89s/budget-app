Rails.application.routes.draw do
  resources :categories
  resources :purchases
  resources :splash_screen, only: %i[index], path: :welcome
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "categories#index"
end
