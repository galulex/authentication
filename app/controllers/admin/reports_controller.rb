class Admin::ReportsController < ApplicationController

  add_breadcrumb I18n.t('breadcrumbs.administration'), :admin_path
  add_breadcrumb I18n.t('breadcrumbs.reports'), :admin_reports_path, except: :index
  before_filter lambda { @page_title = I18n.t("page_titles.reports.#{params[:id]}") }, only: :show
  before_filter :prepare_params, only: :show

  def index
  end

  def show
    eval(params[:id]) if params[:commit]
  end

  private

  def dashboard
    @report = DashboardReport.new(params)
  end

  def prepare_params
    if active_filter?('month')
      @date = Date::civil(params[:date][:year].to_i, params[:date][:month].to_i)
      params[:start] = @date
      params[:end] = @date.at_end_of_month
    elsif active_filter?('range') && params[:start]
      @date = Date.parse params[:start]
    else
      @date = Date.today
      params[:start] ||= @date.at_beginning_of_month
      params[:end] ||= @date.at_end_of_month
    end
  end

  def active_filter?(filter)
    if params[:filter]
      filter == params[:filter]
    else
      filter == 'range'
    end
  end
  helper_method :active_filter?

end
