class UsersController < ApplicationController

  def new
    @partner = User::Partner.new
  end

  def create
    @partner = User::Partner.new(params[:user])
    if @success = @partner.valid?
      @partner.role_id = User::ROLES.invert[User::ADMIN]
      @partner.save
      UserMailer.confirmation(@partner).deliver
      flash[:notice] = I18n.t('flash.user.registration_mail_sent')
    end
  end

  def edit
    if current_user
      @partner = current_user
    else
      @partner = User::Partner.find_by_token(params[:id])
      if @partner && !@partner.invited?
        @partner.activate
        flash[:notice] = I18n.t('flash.user.registration_confirmed')
        redirect_to root_path
      end
    end
  end

  def update
    @partner = User.find(params[:id])
    @success = @partner.update_attributes(params[:user])
    respond_to do |format|
      format.js
      format.html do
        if @success
          @partner.activate unless @partner.activated?
          cookies[:auth_token] = @partner.auth_token
          redirect_to root_path, notice: I18n.t('flash.user.registered')
        else
          render :edit
        end
      end
    end
  end

end
