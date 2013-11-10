class ProductResource < ActiveRecord::Base
  mount_uploader :file, FileUploader

  attr_accessible :title, :file
  belongs_to :resourceable, polymorphic: true

  validates :title, presence: true

end
