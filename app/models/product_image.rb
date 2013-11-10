class ProductImage < ActiveRecord::Base
  mount_uploader :file, ImageUploader

  attr_accessible :file
  belongs_to :imageable, polymorphic: true

end
