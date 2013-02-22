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
    product_id = product.is_a?(Product::Draft) ? product.product_id : product.id
    if product.declined?
      flash[:notice] = I18n.t('flash.product.declined')
      ProductNotifier.perform_async(:declined, product_id: product_id, reason: params[:reason])
    else
      flash[:notice] = I18n.t('flash.product.unpublished')
      ProductNotifier.perform_async(:unpublished, product_id: product_id, reason: params[:reason])
    end
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
      ProductNotifier.perform_async(:published, product_id: @product.product_id)
    else
      ProductNotifier.perform_async(:published, product_id: @product.id)
    end
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
