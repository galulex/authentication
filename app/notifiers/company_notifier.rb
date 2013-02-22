class CompanyNotifier
  include Sidekiq::Worker
  include ActionDispatch::Routing
  include Rails.application.routes.url_helpers

  sidekiq_options retry: false

  def perform(action, params = {})
    send(action, params)
  end

  private

  def submitted(params)
    user = User.find(params['user_id'])
    company = user.company
    date = I18n.l(Time.now)
    User::Tenant.admins.each do |admin|
      CompanyMailer.submitted(admin, user, company, date).deliver
      admin.notifications.create(message: I18n.t('notifications.company.submitted', user: user.name, company: company.name,
                                                 date: date, link: edit_admin_partner_path(company)))
    end
  end

  def approved(params)
    company = Company.find(params['company_id'])
    company.users.admins.each do |admin|
      CompanyMailer.approved(admin, company).deliver
      admin.notifications.create(message: I18n.t('notifications.company.approved', company: company.name))
    end
  end

  def declined(params)
    company = Company.find(params['company_id'])
    company.users.admins.each do |admin|
      CompanyMailer.declined(admin, company, params[:reason]).deliver
      admin.notifications.create(message: I18n.t('notifications.company.declined', company: company.name,
                                                 reason: params[:reason], link: edit_admin_company_path(company)))
    end
  end

end
