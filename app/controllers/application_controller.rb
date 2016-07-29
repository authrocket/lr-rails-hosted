class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_user
    unless current_user
      session[:last_url] = request.get? ? url_for(params.dup.permit!.except(:domain, :host, :port, :protocol, :subdomain)) : url_for
      redirect_to new_login_url
    end
  end

  def current_user
    @_current_user ||= AuthRocket::Session.from_token(session[:ar_token]).try(:user)
  end
  helper_method :current_user

  def new_login_url
    ENV['AUTHROCKET_LOGIN_URL']
  end
  helper_method :new_login_url

end
