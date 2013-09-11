class UserMailer < ActionMailer::Base
  default from: "marketplace@mail.com"

  def confirmation(user)
    @user = user
    mail to: user.email, subject: "Marketplace Notification"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Marketplace Notification"
  end

  def invite(user, admin)
    @user, @admin = user, admin
    mail to: user.email, subject: "Marketplace Notification"
  end

  def admin_invite(user)
    @user = user
    mail to: user.email, subject: "Marketplace Notification"
  end

end
