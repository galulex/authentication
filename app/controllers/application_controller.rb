class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def authorize
    redirect_to_back_or_default if current_user.nil?
  end

  def redirect_to_back_or_default
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

end
