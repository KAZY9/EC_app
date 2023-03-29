Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # views/users/registrations内に作成したconfirm.html.erbとcomplete.html.erbもルーティングに追加します。
  devise_scope :user do
    post 'users/sign_up/confirm', to: 'users/registrations#confirm'
    post 'users/sign_up/complete', to: 'users/registrations#complete'
    # get 'users/sign_up/complete', to: 'users/registrations#complete'
  end

  root 'pages#index'
  # get 'pages#show'
  get '/pages/show', to: 'pages#show'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
