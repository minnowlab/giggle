Giggle::Application.routes.draw do
  namespace :admin do
    resources :products
    resources :messages
  end
 
  resources :admins
  resources :sessions, only: [:new, :create, :destroy]
  match '/signup', to: 'admins#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  resources :products, only: [:index, :show]

  root 'products#index'
end
