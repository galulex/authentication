class ProductReview < ActiveRecord::Base

  belongs_to :user
  belongs_to :product

  attr_accessible :title, :review

  validates :title, :review, presence: true

end
