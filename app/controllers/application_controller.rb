class ApplicationController < ActionController::Base
  before_action :require_login
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def logged_in?
    !current_user.nil?
  end
  def log_in(user)
    session[:user_id] = user.id
  end
  def require_login
    redirect_to new_user_session_path if !logged_in?
  end
  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end
