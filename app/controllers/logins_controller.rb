class LoginsController < ApplicationController

  skip_before_filter :require_user

  def login
    if params[:token]
      if AuthRocket::Session.from_token(params[:token], within: 60.seconds)
        session[:ar_token] = params[:token]
      end
    end
    unless require_user
      redirect_to session[:last_url] || root_path
      session[:last_url] = nil
    end
  end

  def logout
    session[:ar_token] = nil
    redirect_to root_path, notice: 'You have been logged out.'
  end

end
