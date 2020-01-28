Rails.application.routes.draw do
  root to: 'users#home'
  get 'users/new'   => 'users#new', as: :new_user
  post 'users'      => 'users#create'
  get '/login'      => 'sessions#new'
  post '/login'     => 'sessions#create'
  delete '/logout'  => 'sessions#destroy'
  get '/home'       => 'users#home'
end
