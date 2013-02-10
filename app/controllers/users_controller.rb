class UsersController < ApplicationController

  def new
    @partner = User::Partner.new
  end

  def create
    @partner = User::Partner.new(params[:user])
    if @success = @partner.valid?
      @partner.role_id = USER::ROLES.invert[ADMIN]
      @partner.save
      UserMailer.confirmation(@partner).deliver
      flash[:notice] = 'Registration mail sent'
    end
  end

  def edit
    if current_user
      @partner = current_user
    else
      @partner = User::Partner.find_by_token(params[:id])
      unless @partner.nil?
        @partner.activate
        flash[:notice] = 'Registration confirmed'
        redirect_to root_path
      end
    end
  end

  def update
    @partner = User.find(params[:id])
    @success = @partner.update_attributes(params[:user])
  end

end
