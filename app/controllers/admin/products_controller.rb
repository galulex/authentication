class Admin::ProductsController < ApplicationController

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
        flash.now[:notice] = 'Saved'
        render :edit
      else
        @product.submit!
        redirect_to admin_products_path,  notice: 'Submited'
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
    redirect_to :back, alert: 'Product is pending' if product.pending?
  end

  def update
    if product.update_attributes(params[:product])
      if params[:save]
        flash.now[:notice] = 'Saved'
        render :edit
      else
        product.submit!
        redirect_to admin_products_path,  notice: 'Submited'
      end
    else
      render :edit
    end
  end

  def destroy
    product.retract! if product.published?
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
