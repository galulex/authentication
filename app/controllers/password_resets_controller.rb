class PasswordResetsController < ApplicationController

  before_filter :find_user, :only => [:edit, :update]

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      redirect_to root_url, :notice => "Email sent with password reset instructions."
    else
      flash.now[:error] = params[:email].blank? ? 'Enter email address please' : 'User does not exist'
      render :new
    end
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Password has been reset."
    else
      render :edit
    end
  end

  private

  def find_user
    @user = User.find_by_password_reset_token(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:error] = "Password reset has expired."
      redirect_to root_path
    end
  end

end
