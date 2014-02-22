Giggle::Application.routes.draw do

  resource :session, only: [:create, :destroy]
  get '/sign-up', to: 'users#new', as: :sign_up

  namespace :admin do
    root 'products#index'
    resources :products do
      member do
        patch :setting_cover, :publish_operation
      end
    end
    resources :product_pictures
    resources :messages, except: [:show, :new, :create] 
    resources :users
    resources :product_categories
    resources :evaluates do
      member do
         post :create_message
         delete :destroy_message
        end
      end
  end

  resources :products, only: [:index, :show] do

    resources :messages, only: [:index, :create, :destroy] do
      collection do
        post :create_evaluate_message
      end
    end
    resources :evaluates
    resource :collectionship, only: [:create, :destroy]
    
  end
  resource :likeship, only: [:create, :destroy]
  
  resources :users, only: [:index, :show, :create] do
    member do
      get :all_evaluates
    end
  end

  resource :account, only: [:edit, :update] do
    collection do
      get :change_password
      patch :update_password, :setting_cover
    end
    resources :user_pictures, only: [:index, :show, :create, :destroy]
  end

  resources :notifications, only: [:index, :destroy]

  root 'products#index'
end
