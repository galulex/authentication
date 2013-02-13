class Product < ActiveRecord::Base

  belongs_to :company

  attr_accessible :description, :features, :name, :summary, :support, :version
end
