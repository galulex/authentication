class Admin::PartnerProductsController < AdminsController

  before_filter :authorize, :require_tenant

  add_breadcrumb I18n.t('breadcrumbs.administration'), :admin_path
  add_breadcrumb I18n.t('breadcrumbs.partner_products'), :admin_partner_products_path, except: :index

  def index
    @products = Product.page(params[:page])
  end

  def edit
    product
  end

  def update
    if product.update_attributes(params[:product])
      publish if params[:publish]
      save if params[:save]
      preview if params[:preview]
    else
      render :edit
    end
  end

  def show
    product
  end

  def destroy
    if params[:reason].blank?
      product
      flash.now[:error] = I18n.t('flash.company.blank_reason')
    else
      @success = product.decline! if product.pending?
      @success = product.unpublish! if product.published?
      flash[:notice] = I18n.t("flash.product.#{product.status}")
      ProductNotifier.perform_async(product.status, product_id: product.product_id, reason: params[:reason])
    end
  end

  private

  def product
    product = Product.friendly.find(params[:id])
    @product = product.draft || product
  end

  def publish
    @product.approve!
    ProductNotifier.perform_async(:published, product_id: @product.product_id)
    redirect_to admin_partner_products_path, notice: I18n.t('flash.product.published')
  end

  def save
    flash.now[:notice] = I18n.t('flash.product.saved')
    render :edit
  end

  def preview
    render 'products/show', layout: 'dashboard'
  end

end
