Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  get 'users/:id/request', to: 'users#request_friend'
  get 'users/:id/accept', to: 'users#accept_friend'
  get 'users/:id/decline', to: 'users#decline_friend'
  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  devise_scope :user do
    post 'api/login', to: 'users/sessions#create'
    post 'api/signup', to: 'users/registrations#create'
    delete 'api/logout', to: 'users/sessions#create'
  end
  
  namespace :api do
    namespace :v1 do
      get 'posts', to: 'posts#index'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
