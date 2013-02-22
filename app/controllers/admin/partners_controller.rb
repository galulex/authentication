class Admin::PartnersController < AdminsController

  add_breadcrumb I18n.t('breadcrumbs.administration'), :admin_path
  add_breadcrumb I18n.t('breadcrumbs.partners'), :admin_partners_path, except: :index

  before_filter :find_company, except: [:new, :create, :index]

  def index
    @companies = Company.page(params[:page])
  end

  def new
    @partner = User::Partner.new
  end

  def show
  end

  def create
    @partner = User::Partner.new(params[:user])
    if @partner.save
      redirect_to admin_partners_path, notice: I18n.t('flash.partner.created')
    else
      render :new
    end
  end

  def update
    if @company.update_attributes(params[:company])
      if params[:save]
        flash[:notice] = I18n.t('flash.company.saved')
        render :edit
      else
        @company.approve!
        @company.company.replace_with_draft!
        @company.company.destroy_draft!
        CompanyNotifier.perform_async(:approved, company_id: @company.company_id)
        redirect_to admin_partners_path, notice: I18n.t('flash.company.published')
      end
    else
      render :edit
    end
  end

  def destroy
    unless params[:reason].blank?
      @success = @company.decline!
      CompanyNotifier.perform_async(:declined, company_id: @company.company_id, reason: params[:reason])
    end
  end

  private

  def find_company
    company = Company.find(params[:id])
    @company = company.draft || company.instantiate_draft!
  end

end
