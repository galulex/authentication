class ProductsController < ApplicationController

  layout 'dashboard'

  def index
    # @search = Product.search { fulltext params[:search] }
    # @products = @search.results
    @products  = Product.search(params[:search])
  end

  def show
    @product = Product.where(slug: params[:id]).includes(reviews: :user).first
    if current_user
      @reviewed = @product.reviews.find_by_user_id(current_user.id)
    end
  end

  def update
    @product = Product.friendly.find(params[:id])
    @product.rate_it!(current_user, params[:score])
  end

end
