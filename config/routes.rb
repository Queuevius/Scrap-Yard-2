Rails.application.routes.draw do
  resources :time_banks
  resources :taggings
  resources :comments
  resources :videos
  resources :feeds
  resources :wants_attachments
  resources :have_attachments
  resources :pics
  resources :friendships do
    member do
      post :friendships
    end
  end
  resources :trackings
  resources :area
  post 'area/create'
  post 'area/edit'
  get 'area/:id' => 'area#solo_pic'

  get 'area/:id/new_layer' => 'area#new_layer'
  post 'area/:id/create_layer' => 'area#create_layer'

  get 'posts/new_des' => 'posts#new_design'

  get 'posts/homepage' => 'posts#homepage'
  get 'posts/messages' => 'posts#messages'

  post 'profiles/update_pic' => 'profiles#update_pic'

  get '/profile_posts' => 'profiles#profile_posts'
  get 'have/:id' => 'haves#profile_have', as: :profile_have
  get 'want/:id' => 'wants#profile_want', as: :profile_want
  get '/profile_tags' => 'profiles#profile_tag'

  get '/chat' => 'profiles#chat'

  get '/public_feed' => 'posts#public_feed'

  get 'pic/:id' => 'pics#solo_pic', as: :solo_pic

  get 'video/:id' => 'videos#show_video', as: :show_video

  get '/show_have' => 'haves#show_have'

  get '/show_want' => 'wants#show_want'

  resources :rooms
  resources :messages

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  resources :haves

  resources :wants

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

  root to: 'posts#homepage'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  namespace :admin do
    resources :users
  end

  resources :users do
    member do

      resources :items do
        get :items, on: :member
      end
      post :profile_update, to: 'profiles#update'
      get :profile_edit, to: 'profiles#edit'
    end
  end

  # form_for is easier to use with a resourceful route
  resources :contact_forms, only: [:create]
  resources :profiles
  get 'contact' => 'contact_forms#new', as: 'contact'
  post '/users/edit' => 'users/registrations#update'
  # post '/update_user' => 'users/registrations#update'
end
