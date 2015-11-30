class LoginsController < ApplicationController

  def login
    if params[:token]
      if AuthRocket::Session.from_token(params[:token])
        session[:ar_token] = params[:token]
      end
    end
    unless require_user
      redirect_to session[:last_url] || root_path
      session[:last_url] = nil
    end
  end

  def logout
    # assumes realm is using managed sessions (remove if that's not the case):
    AuthRocket::Session.delete session[:ar_token] if session[:ar_token]

    session[:ar_token] = nil
    redirect_to root_path, notice: 'You have been logged out.'
  end

end
