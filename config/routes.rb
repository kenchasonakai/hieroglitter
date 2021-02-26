Rails.application.routes.draw do
  root to: 'posts#new'
  resources :posts, only: [:new, :create]
  resources :favorites, only: :create
  resources :user_sessions, only: [:new, :create, :destroy]
end
