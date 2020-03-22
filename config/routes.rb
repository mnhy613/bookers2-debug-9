Rails.application.routes.draw do
  devise_for :users
  root :to => 'home#top'
  get 'home/about', 'home#about'
  root 'books#index'

  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す 
  
get 'users/:id/follows' => 'users#follows', as:'follows_users'
get 'users/:id/followers' => 'users#followers', as:'followers_users'

  
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]

end
