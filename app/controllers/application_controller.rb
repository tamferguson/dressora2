class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
    User.find(session[:user_id])
  end
  
  def logged_in?
    User.find_by_id(session[:user_id])
  end
  
  def require_user
    redirect_to signin_url, :notice => "You're not logged in!" if !logged_in?
  end
end
