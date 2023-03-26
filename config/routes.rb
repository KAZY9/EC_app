Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  # get 'pages#show'
  get '/pages/show', to: 'pages#show'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
