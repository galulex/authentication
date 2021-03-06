class Admin::PartnersController < AdminsController

  before_filter :authorize, :require_tenant

  add_breadcrumb I18n.t('breadcrumbs.administration'), :admin_path
  add_breadcrumb I18n.t('breadcrumbs.partners'), :admin_partners_path, except: :index

  before_filter :find_company, except: [:new, :create, :index]

  def index
    @companies = Company.includes(:draft).order('company_drafts.status DESC, companies.name ASC').page(params[:page])
  end

  def new
    @partner = User::Partner.new
  end

  def show
  end

  def create
    @partner = User::Partner.new(params[:user])
    if @partner.save
      UserNotifier.perform_async(:admin_invite, user_id: @partner.id)
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
        @company.publish!
        CompanyNotifier.perform_async(:approved, company_id: @company.company_id)
        redirect_to admin_partners_path, notice: I18n.t('flash.company.published')
      end
    else
      render :edit
    end
  end

  def destroy
    if params[:reason].blank?
      flash.now[:error] = I18n.t('flash.company.blank_reason')
    else
      @success = @company.decline!
      CompanyNotifier.perform_async(:declined, company_id: @company.company_id, reason: params[:reason])
    end
  end

  private

  def find_company
    company = Company.friendly.find(params[:id])
    @company = company.draft || company.build_draft(company.attributes)
  end

end
