class ProductPricing < ActiveRecord::Base
  attr_accessible :from, :price, :to
  belongs_to :pricingable, polymorphic: true

  validates :from, :to, :price, presence: true
end
