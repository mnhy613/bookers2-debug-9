Rails.application.routes.draw do
  devise_for :users
  root :to => 'home#top'
  get 'home/about', 'home#about'
  root 'books#index'
  resources :users
  resources :books
end
