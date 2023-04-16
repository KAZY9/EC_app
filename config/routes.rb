Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  # views/users/registrations内に作成したconfirm.html.erbとcomplete.html.erbもルーティングに追加します。
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

  get '/mypage/', to: 'pages#mypage'
  root 'pages#index'
  # get 'pages#show'
  get '/pages/show', to: 'pages#show'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
