class DashboardController < ApplicationController

  layout 'dashboard'

  def index
    @products = Product.all
  end
end
