class Admin::PartnerProductsController < AdminsController

  add_breadcrumb I18n.t('breadcrumbs.administration'), :admin_path
  add_breadcrumb I18n.t('breadcrumbs.partner_products'), :admin_partner_products_path, except: :index

  def index
    @products = Product.page(params[:page])
  end

  def edit
    product = Product.find(params[:id])
    @product = product
  end

  def update
    @product = Product.find(params[:id]) || Product::Draft.find(params[:id])
    if @product.update_attributes(params[:product])
      publish if params[:publish]
      save if params[:save]
      preview if params[:preview]
    else
      render :edit
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])
    @product.decline! if @product.pending?
    @prodict.unpublish! if @product.published?
  end

  private

  def publish
    @product.publish!
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
