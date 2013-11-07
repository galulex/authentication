class ProductReviewsController < ApplicationController

  def new
    @review = product.reviews.build
  end

  def create
    @review = product.reviews.build(params[:product_review])
    if @success = @review.valid?
      @review.user = current_user
      @review.save
    end
  end

  def edit
    product
    review
  end

  def update
    product
    @success = review.update_attributes(params[:product_review])
  end

  def destroy
    review.destroy
  end

  private

  def product
    @product ||= Product.friendly.find(params[:product_id])
  end

  def review
    @review ||= current_user.product_reviews.find(params[:id])
  end

end
