Rails.application.routes.draw do

  root 'app_pages#home'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users, except: [:destroy]
  resources :orders, except:[:edit, :update]
  resources :drivers, except: [:destroy]

  get '/users/:id/topup', to: 'users#topup', as: 'user_topup'
  get '/drivers/:id/setlocation', to: 'drivers#setlocation', as: 'driver_setlocation'

end
