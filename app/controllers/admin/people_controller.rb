class Admin::PeopleController < AdminsController

  add_breadcrumb I18n.t('breadcrumbs.administration'), :admin_path
  add_breadcrumb I18n.t('breadcrumbs.manage_people'), :admin_people_path, except: :index

  def index
    @people = company.users.activated.page(params[:page])
  end

  def new
    @users = [company.users.build(role_id: User::ROLES.invert[User::EMPLOYEE] )]
  end

  def create
    @users = []
    params[:users].each do |attrs|
      @users << current_user.class.new(attrs)
    end
    company.users << @users
    if company.valid?
      redirect_to invites_admin_people_path, notice: I18n.t('flash.user.invite_sent')
    else
      render :new
    end
  end

  def update
    user = company.users.find(params[:id])
    user.update_attributes(role_id: params[:role_id])
    flash.now[:notice] = t('flash.user.role_updated')
  end

  def destroy
    @user = company.users.find(params[:id]).destroy
    if @user.activated?
      redirect_to admin_people_path, notice: t('flash.user.deleted', name: @user.name)
    else
      redirect_to invites_admin_people_path, notice: t('flash.user.invite_canceled')
    end
  end

  def invites
    @users = company.users.invited
  end

  private

  def company
    @company ||= current_user.company
  end

end
