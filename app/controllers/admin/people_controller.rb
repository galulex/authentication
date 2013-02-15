class Admin::PeopleController < AdminsController

  add_breadcrumb I18n.t('breadcrumbs.administration'), :admin_path

  def index
    @people = current_user.company.users.page(params[:page])
  end

end
