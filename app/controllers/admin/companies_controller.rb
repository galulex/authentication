class Admin::CompaniesController < ApplicationController

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
    end
  end

end
