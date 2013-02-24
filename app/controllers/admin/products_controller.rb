class Admin::ProductsController < AdminsController

  before_filter :authorize, :require_partner

  add_breadcrumb I18n.t('breadcrumbs.administration'), :admin_path

  def index
    @products = current_user.company.products.page(params[:page])
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.company.products.build(params[:product])
    if @product.save
      if params[:save]
        flash.now[:notice] = I18n.t('flash.product.saved')
        render :edit
      else
        @product.submit!
        product_id = @product.is_a?(Product) ? @product.id : @product.product_id
        ProductNotifier.perform_async(:submitted, user_id: current_user.id, product_id: product_id)
        redirect_to admin_products_path, notice: I18n.t('flash.product.submitted')
      end
    else
      render :new
    end
  end

  def show
    product
    render 'products/show', layout: 'dashboard'
  end

  def edit
    redirect_to admin_products_path, alert: I18n.t('flash.product.pending') if product.pending?
  end

  def update
    if product.update_attributes(params[:product])
      if params[:save]
        flash.now[:notice] = I18n.t('flash.product.saved')
        render :edit
      else
        product.submit!
        product_id = @product.is_a?(Product) ? @product.id : @product.product_id
        ProductNotifier.perform_async(:submitted, user_id: current_user.id, product_id: product_id)
        redirect_to admin_products_path,  notice: I18n.t('flash.product.submitted')
      end
    else
      render :edit
    end
  end

  def destroy
    @product = current_user.company.products.find(params[:id])
    if @product.published?
      @product.retract!
      ProductNotifier.perform_async(:retracted, user_id: current_user.id, product_id: @product.id)
    end
    redirect_to admin_products_path
  end

  private

  def product
    product = current_user.company.products.find(params[:id])
    if !product.published?
      @product = product
    else
      @product = product.draft || product.instantiate_draft!
    end
  end

end
