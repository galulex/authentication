class Reports::Registration

  FIELDS = [:name, :email, :user_type, :company_name, :created_on, :activated]

  attr_accessor :activated_users_count, :not_activated_users_count, :users

  def initialize(params)
    @activated_users_count = User.where(token: nil).size
    @not_activated_users_count = User.where('token IS NOT NULL').size
    @users = User.includes(:company).all_by_activation_status(params[:user_status])
  end

  def csv(options = {})
    CSV.generate(options) do |csv|
      csv << FIELDS.map { |e| I18n.t("admin.reports.registration.#{e}") }
      @users.each do |u|
        csv << [u.name, u.email, u.type, u.company.name, I18n.l(u.created_at), I18n.t("#{u.activated?}")]
      end
    end
  end

end
