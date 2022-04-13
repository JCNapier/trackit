Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'welcome_page#index'

  get '/login', to: 'users#new'
  post '/login', to: 'users#login'

  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create]
end
