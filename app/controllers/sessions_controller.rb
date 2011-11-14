class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_url(user), :notice => "Welcome back, #{user.f_name}!"
    else
      render :new 
      flash[:notice] = "Please, try again!"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to signin_url, :notice => "You have signed out."
  end
  

end
