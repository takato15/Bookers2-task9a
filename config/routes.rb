Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
   resources :post_comments, only: [:create, :destroy]
   resource :favorites, only: [:create, :destroy]
  end


end