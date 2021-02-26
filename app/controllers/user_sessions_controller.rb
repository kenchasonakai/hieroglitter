class UserSessionsController < ApplicationController
  skip_before_action :require_login
  def new
    redirect_to root_path if logged_in?
  end
  def create
    user_id = rand(1..5)
    user = User.find(user_id)
    session[:user_id] = user.id if !session[:user_id]
    redirect_to root_path
  end
  def destroy
    logout if logged_in?
    redirect_to root_path
  end
end
