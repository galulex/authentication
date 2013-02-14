class Admin::PartnersController < ApplicationController

  def index
    @companies = Company.page(params[:page])
  end

  def new
    @partner = User::Partner.new
  end

  def create
    @partner = User::Partner.new(params[:user])
    if @partner.save
      redirect_to admin_partners_path, notice: 'Done'
    else
      render :new
    end
  end

  def edit
    company = Company.find(params[:id])
    @company = company.draft || company
  end

  def show
    @company = Company::Draft.find(params[:id])
  end

  def update
    @company = Company::Draft.find(params[:id])
    if @company.update_attributes(params[:company])
      if params[:save]
        flash[:notice] = 'Saved'
        render :edit
      else
        @company.approve!
        @company.company.replace_with_draft!
        @company.company.destroy_draft!
        redirect_to admin_partners_path, notice: 'Published'
      end
    else
      render :edit
    end
  end

  def destroy
    @company = Company::Draft.find(params[:id])
    @success = @company.decline!
  end

end
