class Admin::ProductsController < ApplicationController

  def index
    @products = current_user.company.products.page(params[:page])
  end

  def new
    @product = Product.new
  end

  def edit
    product = current_user.company.products.find(params[:id])
    @product = product
  end

  def create
    @product = current_user.company.products.build(params[:product])
    if @product.valid?
      @product.submit
    else
      render :new
    end
  end
end
