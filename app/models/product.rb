class Product < ActiveRecord::Base

  has_many :reviews, class_name: 'ProductReview'
  belongs_to :company

  attr_accessible :description, :features, :name, :summary, :support, :version


  has_attached_file :icon
  has_attached_file :image
  has_attached_file :banner

end
