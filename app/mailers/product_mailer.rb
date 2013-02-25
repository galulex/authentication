class ProductMailer < ActionMailer::Base
  default from: "marketplace@partnerpedia.com"

  def submitted(*args)
    @admin, @user, @company, @product, @date = args
    mail to: @admin.email, subject: "AppZone Marketplace Notification"
  end

  def retracted(*args)
    @admin, @user, @company, @product = args
    mail to: @admin.email, subject: "AppZone Marketplace Notification"
  end

  def declined(*args)
    @user, @product, @reason = args
    mail to: @user.email, subject: "AppZone Marketplace Notification"
  end

  def unpublished(*args)
    @user, @product, @reason = args
    mail to: @user.email, subject: "AppZone Marketplace Notification"
  end

  def published(*args)
    @user, @company, @product = args
    mail to: @user.email, subject: "AppZone Marketplace Notification"
  end

end
