class ProductMailer < ActionMailer::Base
  default from: "marketplace@mail.com"

  def submitted(*args)
    @admin, @user, @company, @product, @date = args
    mail to: @admin.email, subject: "Marketplace Notification"
  end

  def retracted(*args)
    @admin, @user, @company, @product = args
    mail to: @admin.email, subject: "Marketplace Notification"
  end

  def declined(*args)
    @user, @product, @reason = args
    mail to: @user.email, subject: "Marketplace Notification"
  end

  def unpublished(*args)
    @user, @product, @reason = args
    mail to: @user.email, subject: "Marketplace Notification"
  end

  def published(*args)
    @user, @company, @product = args
    mail to: @user.email, subject: "Marketplace Notification"
  end

end
