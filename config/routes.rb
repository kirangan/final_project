Rails.application.routes.draw do
  get 'admin/index'
  root 'sessions#create'
  
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users
  resources :orders
end
