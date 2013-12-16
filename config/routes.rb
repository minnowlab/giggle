Giggle::Application.routes.draw do

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
  
  resource :user do
    member do
      get :change_password
      get :change_name
      patch :update_name
      patch :update_password
    end
  end

  root 'products#index'
end
