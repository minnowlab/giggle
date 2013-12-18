Giggle::Application.routes.draw do

  get "user_pictures/show"
  resource :session, only: [:create, :destroy]

  namespace :admin do
    root 'products#index'
    resources :products do
      member do
        patch :setting_cover
      end
    end
    resources :product_pictures
    resources :messages 
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
    resources :messages, except: [:new, :show] do
      collection do
        post :create_evaluate_message
      end
    end
    resources :evaluates
  end
  
  resources :users, only: [:index, :show] do
    member do
      patch :setting_cover
      get :show_evaluates
    end
  end

  resource :account, only: [:edit, :update] do
    collection do
      get :change_password
      patch :update_password
    end
    resources :user_pictures, only: [:show, :destroy]
  end

  root 'products#index'
end
