class PasswordResetsController < ApplicationController

  before_filter :find_user, :only => [:edit, :update]

  def create
    user = User.find_by_email(params[:email])
    if @success = user
      user.reset_password
      UserMailer.password_reset(user).deliver
      flash[:notice] = "Email sent with password reset instructions."
    else
      @error = params[:email].blank? ? 'Enter email address please' : 'User does not exist'
    end
  end

  def update
    if @success = @user.update_attributes(params[:user])
      flash[:notice] = "Password has been reset."
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
