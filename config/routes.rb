Rails.application.routes.draw do

  get 'sessions/create'
  get 'sessions/destroy'
  resources :friendships, only: [:create, :update, :destroy]
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
  resources :comments, only: [:create]
  resources :likes, only: [:create, :destroy]
  end

  get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'home', to: 'home#show'
  get 'me', to: 'me#show', as: 'me'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
