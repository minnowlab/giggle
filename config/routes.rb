Giggle::Application.routes.draw do
  get '/sign-in', to: 'sessions#new', as: :user_sign_in
  delete '/sign-out', to: 'sessions#destroy', as: :user_sign_out
  resources :sessions, only: :create

  namespace :admin do
    root 'products#index'
    resources :products
    resources :messages
  end
 
  resources :admins
  match '/signup', to: 'admins#new', via: 'get'

  resources :products, only: [:index, :show]

  root 'products#index'
end
