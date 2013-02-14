class AllLoginsController < ApplicationController
  layout false

  def index
    if params[:char]
      @companies = Company.where('name LIKE ?', "#{params[:char]}%").page(params[:page]).per(5)
    else
      @companies = Company.page(params[:page]).per(5)
    end
  end

  def show
    user = User.find(params[:id])
    cookies[:auth_token] = user.auth_token
    redirect_to :root
  end

  def search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

end
