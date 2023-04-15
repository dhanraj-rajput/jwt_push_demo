require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  ActiveAdmin.routes(self)
  
  
  resources :admin
  post '/auth/login', to: 'authentication#login'
  resources :users
  put '/users/:id' ,to:"users#update"
  delete'/users/:id' ,to:"users#destroy"
  resources :posts
  resources :comments
  resources :likes

  post '/comments/:id', to: "comments#create_reply"

end



  




