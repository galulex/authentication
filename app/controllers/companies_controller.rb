class CompaniesController < ApplicationController
  layout 'dashboard'

  def show
    @company = Company.find(params[:id])
  end

end
