Rails.application.routes.draw do
  
  # resources :users do
  #   resources :posts
  # end
  post '/auth/login', to: 'authentication#login'

  resources :users
  resources :posts
  resources :comments
  resources :likes

  post'/comments/:id',to:"comments#create_reply"



  # # this routs for post
  #   post '/users/', to: 'users#create'

  #   # this routs for show
  #   get '/users/', to: 'users#show'

  #   #this routs for list index
  #   get '/users/', to: 'users#index'


  #   #this routs for list index
  #   put '/users/', to: 'users#update'
  #   patch '/users/', to: 'users#update'


  #   #this routs for list destroy
  #   delete '/users/', to: 'users#destroy'

  # ASSOCIATION  define relestionship between two models 
  #type of association
  #1 - has_one
  #2 - has_many
  #3 - belongs_to
  #4 - has_many through
  #5 - has and belongs to many
  #6 - has_one :through



end
