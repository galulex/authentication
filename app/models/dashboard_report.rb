class DashboardReport

  attr_accessor :logins_count, :users_count, :new_users_count, :companies_count, :new_companies_count

  def initialize(params)
    @logins_count = Login.count
    @users_count = User.where('created_at <= ?', params[:end]).size
    @new_users_count = User.where('created_at >= ? AND created_at <= ?', params[:start], params[:end]).size
    @companies_count = Company.where('created_at <= ?', params[:end]).size
    @new_companies_count = Company.where('created_at >= ? AND created_at <= ?', params[:start], params[:end]).size
  end

end
