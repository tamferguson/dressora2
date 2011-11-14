module ApplicationHelper
  def current_user
    User.find(session[:user_id])
  end
  
  def logged_in?
    User.find_by_id(session[:user_id])
  end
end
