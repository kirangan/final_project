Rails.application.routes.draw do
 
  get 'admin/index'
  root 'home#index', as: 'home_index'
  
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users
  resources :orders
end
