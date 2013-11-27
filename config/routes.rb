Giggle::Application.routes.draw do
  get "evaluates/index"
  get "evaluates/show"
  get "evaluates/new"
  get "evaluates/edit"
  get '/sign-in', to: 'sessions#new', as: :user_sign_in
  delete '/sign-out', to: 'sessions#destroy', as: :user_sign_out
  resources :sessions, only: :create

  namespace :admin do
    root 'products#index'
    resources :products
    resources :messages 
#    do
#      collection do
#        get :index_products, :index_evaluates
#      end
#    end
    resources :users
    resources :product_categories
    resources :evaluates do
      member do
         post :create_message
         delete :destroy_message
        end
      end
  end
 
  resources :admins
  match '/signup', to: 'admins#new', via: 'get'

  resources :products, only: [:index, :show]

  root 'products#index'
end
