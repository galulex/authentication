class ProductDraft < ActiveRecord::Base
  include BaseProduct

  belongs_to :product

  def user_rating(user)
    product.user_rating(user)
  end

  def company
    product.company
  end

  def reviews
    product.reviews
  end

  def ratings
    product.ratings
  end

  def to_param
    product.to_param
  end

  def approve!
    publish
    product.attributes = attributes
    product.images = images
    destroy
  end

end
