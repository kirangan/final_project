class SessionsController < ApplicationController
  
  # skip_before_action :authorize


  def new
  end

  def create
    user = User.find_by(username: params[:username])
    driver = Driver.find_by(username: params[:username])
      
    if user.try(:authenticate, params[:password]) && params[:role] == 'user'
      # log_in user
      session[:user_id] = user.id
      session[:role] = params[:role]
      redirect_to users_path

    elsif driver.try(:authenticate, params[:password]) && params[:role] == 'driver'
      # log_in_driver driver
      session[:driver_id] = driver.id
      session[:role] = params[:role]
      redirect_to drivers_path
   
    else
        redirect_to login_url, alert: "Invalid username/password combination"
    end
  end

  def destroy
    if session[:role] == 'user'
      session[:user_id] = nil
      redirect_to root_path, notice: "Logged out"
    else
      session[:driver_id] = nil
      redirect_to root_path, notice: "Logged out"
    end

  end
  

end