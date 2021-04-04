Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
  # devise_for :users
  root 'home#top'
  get 'home/about'
end
