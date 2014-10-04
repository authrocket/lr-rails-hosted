module ApplicationHelper

  def current_user
    @_current_user ||= AuthRocket::User.retrieve session[:user_id]
    session[:user_id] = nil unless @_current_user
    @_current_user
  end

  def current_name
    session[:user_id] && session[:name]
  end

end
