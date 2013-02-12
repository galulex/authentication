class Product < ActiveRecord::Base
  attr_accessible :description, :features, :name, :summary, :support, :version
end
