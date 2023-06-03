Rails.application.routes.draw do
  scope module: :customer do
    resources :products, only: [:index, :show]
    root 'products#index'
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

  scope :mypage do
    resources :addresses, except: [:show] 
    resources :cards, only: [:new, :create, :destroy]
  end

  get '/mypage/', to: 'pages#mypage'
  get '/pages/show', to: 'pages#show'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
