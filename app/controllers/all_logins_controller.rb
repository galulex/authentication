class AllLoginsController < ApplicationController
  layout false

  def index
    @companies = Company.starts_with(params[:char]).includes(:users).page(params[:page]).per(5)
  end

  def show
    user = User.find(params[:id])
    cookies[:auth_token] = user.auth_token
    user.logins.create
    redirect_to :root
  end

end
