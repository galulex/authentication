class ProductVideo < ActiveRecord::Base
  attr_accessible :url
  belongs_to :videoable, polymorphic: true

  validates :url, presence: true
end
