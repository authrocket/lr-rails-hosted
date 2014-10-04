class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_user
    unless session[:user_id]
      session[:last_url] = request.get? ? url_for(params) : url_for
      redirect_to new_login_url
    end
  end

  def new_login_url
    ENV['AUTHROCKET_LOGIN_URL']
  end
  helper_method :new_login_url

end
