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

  def show
    @product = Product.find(params[:id])
  end
end
