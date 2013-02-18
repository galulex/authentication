class PasswordResetsController < ApplicationController

  before_filter :find_user, :only => [:edit, :update]

  def create
    user = User.find_by_email(params[:email])
    if @success = user && !flash[:error]
      user.reset_password
      UserMailer.password_reset(user).deliver
      flash[:notice] = I18n.t('flash.reset_password.email_sent')
    else
      flash.now[:error] = params[:email].blank? ? I18n.t('flash.reset_password.email_blank') : I18n.t('flash.reset_password.user_does_not_exist')
    end
  end

  def update
    if @success = @user.update_attributes(params[:user])
      flash[:notice] = I18n.t('flash.reset_password.done')
    end
  end

  private

  def find_user
    @user = User.find_by_password_reset_token(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:error] = I18n.t('flash.reset_password.expired')
    end
  end

end
