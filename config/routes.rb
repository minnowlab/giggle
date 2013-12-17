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
  
  resources :users do
    member do
      get :change_password
      get :change_name
      patch :update_name
      patch :update_password
      patch :setting_cover
      get :show_user
      get :show_users
    end
  end

  resources :user_pictures

  root 'products#index'
end
