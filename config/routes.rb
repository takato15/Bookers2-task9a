Rails.application.routes.draw do

  get 'chats/show'
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  resources :searches, only: [:index]
  # post 'conversations/create' => 'conversations#create'

  resources :conversations do
    resources :messages
  end

  resources :users,only: [:show,:index,:edit,:update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :books do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
  end

end