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
      unless @partner.nil?
        @partner.activate
        flash[:notice] = I18n.t('flash.user.registration_confirmed')
        redirect_to root_path
      end
    end
  end

  def update
    @partner = User.find(params[:id])
    @success = @partner.update_attributes(params[:user])
  end

end
