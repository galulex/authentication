class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    if user && !user.activated?
      @error = I18n.t('flash.user.your_account_not_activated')
    elsif @success = (user && user.authenticate(params[:password]))
      params[:remember_me] ? cookies.permanent[:auth_token] = user.auth_token : cookies[:auth_token] = user.auth_token
      user.logins.create
    else
      @error = I18n.t('flash.user.invalid_email_or_password')
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, :notice => I18n.t('flash.user.logged_out')
  end

end
