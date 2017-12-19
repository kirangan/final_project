Rails.application.routes.draw do

  root 'app_pages#home'
  get 'app_pages/about'
  # get '/signup_user', to: "users#new"
  # get '/signup_driver', to: "drivers#new"

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users
  resources :orders
  resources :drivers

  get '/users/:id/topup', to: 'users#topup', as: 'user_topup'
  get '/drivers/:id/setlocation', to: 'drivers#setlocation', as: 'set_location'
  resources :locations
end
