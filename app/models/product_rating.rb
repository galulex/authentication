class ProductRating < ActiveRecord::Base

  belongs_to :product, touch: true
  belongs_to :user
  attr_accessible :score

  validates :score, presence: true

  after_save :update_rating_average

  def update_rating_average
    product.update_column(:rating_average, product.ratings.average(:score))
  end

end
