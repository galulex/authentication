class Admin::CompaniesController < AdminsController

  add_breadcrumb I18n.t('breadcrumbs.administration'), :admin_path

  def edit
    @company = current_user.company.draft || current_user.company.instantiate_draft!
  end

  def update
    company = current_user.company
    @company = company.draft || company.instantiate_draft!
    if @company.update_attributes(params[:company])
      if params[:save]
        flash.now[:notice] = 'Done'
        render :edit
      else
        @company.submit
        redirect_to :root, notice: 'Submited'
      end
    else
      render :edit
    end
  end

end
