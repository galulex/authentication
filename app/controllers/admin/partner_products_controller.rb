class Admin::PartnerProductsController < AdminsController

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
    @action = product.pending? ? 'decline' : 'unpublish'
  end

  def destroy
    @success = product.decline! if product.pending?
    @success = product.unpublish! if product.published?
    flash[:notice] = product.declined? ? 'Declined' : 'Unpublished'
  end

  private

  def product
    product = Product.find(params[:id])
    @product = product.draft || product
  end

  def publish
    @product.publish! unless @product.published?
    if @product.is_a?(Product::Draft)
      @product.product.replace_with_draft!
      @product.product.destroy_draft!
    end
    redirect_to admin_partner_products_path, notice: 'Published'
  end

  def save
    flash.now[:notice] = 'Saved'
    render :edit
  end

  def preview
    render 'products/show', layout: 'dashboard'
  end

end
