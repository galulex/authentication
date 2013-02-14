class AllLoginsController < ApplicationController
  layout 'all_logins'

  def index
    #company = current_user.company
    @companies = Company.all
  end

  def show
    user = User.find(params[:id])
    cookies[:auth_token] = user.auth_token
    redirect_to :root
  end

end
