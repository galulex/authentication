class ProductCategory < ActiveRecord::Base
  belongs_to :categorizable, polymorphic: true
  belongs_to :category
end
