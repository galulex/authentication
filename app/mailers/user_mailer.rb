class UserMailer < ActionMailer::Base
  default from: "marketplace@partnerpedia.com"

  def confirmation(user)
    @user = user
    mail to: user.email, subject: "AppZone Marketplace Notification"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "AppZone Marketplace Notification"
  end

  def invite(user, admin)
    @user, @admin = user, admin
    mail to: user.email, subject: "AppZone Marketplace Notification"
  end

  def admin_invite(user)
    @user = user
    mail to: user.email, subject: "AppZone Marketplace Notification"
  end

end
