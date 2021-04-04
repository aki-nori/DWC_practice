Rails.application.routes.draw do
  get 'searchs/search'
  get 'relationships/create'
  get 'relationships/destroy'
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update] do
    member do
      get :follows    # followユーザ一覧ページ用
      get :followers  # followerユーザ一覧ページ用
    end
  end
  resources :books
  resources :favorites, only: [:create, :destroy]
  resources :book_comments, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  # devise_for :users
  root 'home#top'
  get 'home/about' => 'home#about'
end
