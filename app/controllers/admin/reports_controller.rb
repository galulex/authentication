class Admin::ReportsController < ApplicationController

  #set_title I18n.t("page_titles.reports.#{params[:id]}"), only: :show
  before_filter lambda { @page_title = I18n.t("page_titles.reports.#{params[:id]}") }, only: :show

  def index
  end

  def show
    eval(params[:id]) if params[:commit]
  end

  private

  def dashboard
    @logins = Login.count
    @users = User.where('created_at <= ?', params[:end]).size
    @new_users = User.where('created_at >= ? AND created_at <= ?', params[:start], params[:end]).size
    @companies = Company.where('created_at <= ?', params[:end]).size
    @new_companies = Company.where('created_at >= ? AND created_at <= ?', params[:start], params[:end]).size
  end

  def registration
  end

  private

end
