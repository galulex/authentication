class CompaniesController < ApplicationController
  layout 'dashboard'

  def show
    @company = Company.friendly.find(params[:id])
  end

end
