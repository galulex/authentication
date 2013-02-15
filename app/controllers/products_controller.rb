class ProductsController < ApplicationController

  layout 'dashboard'

  def show
    @product = Product.where(id: params[:id]).includes(reviews: :user).first
    if current_user
      @reviewed = @product.reviews.find_by_user_id(current_user.id)
    end
  end

end
