class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, :notice => "Success"
    else
      render :new
    end
  end

  def edit
    if current_user
      @user = current_user
    else
      @user = User.find_by_token(params[:id])
      unless @user.nil?
        @user.activate
        flash[:notice] = 'Registration confirmed'
      end
      redirect_to :root
    end
  end

end
