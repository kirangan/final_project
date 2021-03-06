class ApplicationController < ActionController::Base
  before_action :authorize
  protect_from_forgery with: :exception

  # include SessionsHelper

  protected

    def authorize
      unless User.find_by(id: session[:user_id]) or Driver.find_by(id: session[:driver_id])
        redirect_to login_url, notice: 'Please Login'
      end
    end
end
