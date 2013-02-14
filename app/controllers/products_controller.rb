class ProductsController < ApplicationController

  layout 'dashboard'

  def show
    @product = Product.find(params[:id])
  end
end
