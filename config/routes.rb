Rails.application.routes.draw do
 
  get 'app_pages/home'

  get 'app_pages/about'

  get 'admin/index'
  root 'home#index', as: 'home_index'
  
  # get "signup" => "signup#new"
  # post "signup" => "signup#create"

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
end
