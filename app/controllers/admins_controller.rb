class AdminsController < ApplicationController

  before_filter :authorize, :require_admin

  def show
    render 'admin/show'
  end

  private

  def require_admin
    redirect_to_back_or_default if !current_user.admin?
  end

  def require_tenant
    redirect_to_back_or_default if !current_user.tenant?
  end

  def require_partner
    redirect_to_back_or_default if !current_user.partner?
  end

end
