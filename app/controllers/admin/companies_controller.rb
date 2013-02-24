class Admin::CompaniesController < AdminsController

  before_filter :authorize, :require_partner

  add_breadcrumb I18n.t('breadcrumbs.administration'), :admin_path

  def edit
    @company = current_user.company.draft || current_user.company.instantiate_draft!
  end

  def update
    company = current_user.company
    @company = company.draft || company.instantiate_draft!
    if @company.update_attributes(params[:company])
      if params[:save]
        flash.now[:notice] = I18n.t('flash.company.saved')
        render :edit
      else
        @company.submit!
        CompanyNotifier.perform_async(:submitted, user_id: current_user.id)
        redirect_to admin_path, notice: I18n.t('flash.company.submitted')
      end
    else
      render :edit
    end
  end

end
