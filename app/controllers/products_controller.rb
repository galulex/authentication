class ProductsController < ApplicationController

  layout 'dashboard'

  def index
    @search = Product.search do
      fulltext params[:search]
    end
    @products = @search.results
  end

  def show
    @product = Product.where(slug: params[:id]).includes(reviews: :user).first
    if current_user
      @reviewed = @product.reviews.find_by_user_id(current_user.id)
    end
  end

  def update
    @product = Product.find(params[:id])
    @product.rate_it!(current_user, params[:score])
  end

end
