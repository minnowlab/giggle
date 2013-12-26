Giggle::Application.routes.draw do

  get "user_pictures/show"
  resource :session, only: [:create, :destroy]

  namespace :admin do
    root 'products#index'
    resources :products do
      member do
        patch :setting_cover, :publish_operation
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
    resource :collectionship, only: [:create, :destroy]
    
    collection do
      post :preview_markdown
    end
  end
  resources :likeships, only: [:create, :destroy]
  
  resources :users, only: [:index, :show] do
    member do
      get :show_evaluates, :show_collections
    end
  end

  resource :account, only: [:edit, :update] do
    collection do
      get :change_password
      patch :update_password, :setting_cover
    end
    resources :user_pictures, only: [:index, :show, :create, :destroy]
  end

  root 'products#index'
end
