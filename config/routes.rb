Rails.application.routes.draw do
  namespace :customer do
    get 'carts/index'
  end
  scope module: :customer do
    resources :products, only: [:show] do
      resource :favorites, only: [:create, :destroy]
      delete 'destroy_favorite_item', to: 'favorites#destroy_favorite_item', as: 'destroy_favorite_item'
    end
    root 'products#index'
    resources :favorites, only: [:index]
    resources :carts, only: [:index, :create, :destroy] do
      member do
        patch 'increase'
        patch 'decrease'
      end
    end
  end

  namespace :admin do
    resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/sign_up', to: 'users/registrations#new'
    post '/sign_up', to: 'users/registrations#confirm'
    get '/sign_up/complete', to: 'users/registrations#complete'
    post '/sign_up/complete', to: 'users/registrations#create'
    get '/forgot', to: 'users/passwords#new'
    get '/forgot/complete', to: 'users/passwords#complete'
    get '/mypage/login', to: 'users/sessions#new'
    get '/mypage/change', to: 'users/registrations#edit'
  end

  # resources :orders, only: [:buy, :purchase]
  get '/orders', to: 'orders#new'
  post '/orders', to: 'orders#confirm'
  get '/orders/complete', to: 'orders#complete'
  post '/orders/complete', to: 'orders#create'
  resources :shippings, only: [:create]
  get '/shippings/shipping_address', to: 'shippings#shipping_address'
  get '/shippings/new_address', to: 'shippings#new_address'
  post '/shippings/add_address', to: 'shippings#add_address'
  get '/shippings/new_credit', to: 'shippings#new_credit'
  post '/shippings/add_credit', to: 'shippings#add_credit'

  scope :mypage do
    resources :addresses, except: [:show] 
    resources :cards, only: [:new, :create, :destroy]
  end

  get 'search', to: 'searches#search'
  get 'filter_search', to: 'searches#filter_search'

  get '/mypage/', to: 'pages#mypage'
  get '/pages/show', to: 'pages#show'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
