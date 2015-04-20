class SignupsController < ApplicationController

  def create
    if params[:token]
      user = AuthRocket::User.create(token: params[:token])
      if user.valid?
        flash[:notice] = 'Thanks for signing up!'
        # requires realm to use managed sessions (remove if that's not the case):
        session[:ar_token] = user.create_session(ip: request.ip, client: request.headers['User-Agent']).try(:token)
      else
        flash[:alert] = user.errors.full_messages.join(' ')
      end
      redirect_to root_path
    else
      redirect_to new_signup_path
    end
  end

end
