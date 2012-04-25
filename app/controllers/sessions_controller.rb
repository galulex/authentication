class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    if user && !user.activated?
      flash.now[:error] = 'Your account not activated'
      render :new
    elsif user && user.authenticate(params[:password])
      params[:remember_me] ? cookies.permanent[:auth_token] = user.auth_token : cookies[:auth_token] = user.auth_token
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now[:error] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, :notice => "Logged out!"
  end

end
