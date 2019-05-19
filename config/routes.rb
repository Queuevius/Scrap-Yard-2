Rails.application.routes.draw do
  
  get 'area/new'
  post 'area/create'
  get 'area/:id' => 'area#show'

  get 'area/:id/new_layer' => 'area#new_layer'
  post 'area/:id/create_layer' => 'area#create_layer'

  resources :posts do 
    member do 
      get :new_layer
      post :create_layer
      post :create_token
      get :all_tokens
      get :show_token
      post :add_rating
      resources :tokens do 
        resources :comments do 
          get 'add_vote', on: :collection
        end
      end
    end
  end 
  root to: 'posts#index'

  devise_for :users, controllers: {
    # Override the following Devise controllers with our custom versions
    registrations: 'users/registrations'
  }

  namespace :admin do
    resources :users
  end

  # form_for is easier to use with a resourceful route
  resources :contact_forms, only: [:create]
  resources :profiles, only: [:edit]
  get 'contact' => 'contact_forms#new', as: 'contact'
  post '/users/edit' => 'users/registrations#update'
 # post '/update_user' => 'users/registrations#update'
end
