class CompanyMailer < ActionMailer::Base
  default from: "marketplace@partnerpedia.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.company.submitted.subject
  #
  def submitted(*args)
    @admin, @user, @company, @date = args
    mail to: @user.email, subject: "AppZone Marketplace Notification"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.company.declined.subject
  #
  def declined(*args)
    @user, @company, @reason = args
    mail to: @user.email, subject: "AppZone Marketplace Notification"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.company.published.subject
  #
  def approved(*args)
    @user, @company = args
    mail to: @user.email, subject: "AppZone Marketplace Notification"
  end
end
