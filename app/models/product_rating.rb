class ProductRating < ActiveRecord::Base

  belongs_to :product
  belongs_to :user
  attr_accessible :score

  validates :score, presence: true

  after_save :update_rating_average

  private

  def update_rating_average
    product.update_column(:rating_average, product.ratings.average(:score))
  end

end
