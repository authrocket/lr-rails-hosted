class LoginsController < ApplicationController

  skip_before_filter :require_user

  def login
    if params[:token]
      if event = AuthRocket::Event.validate_token(params[:token])
        u = event.user
        session[:user_id] = u.id
        session[:name] = u.name
      end
    end
    unless require_user
      redirect_to session[:last_url] || root_path 
      session[:last_url] = nil
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, notice: 'You have been logged out.'
  end

end
