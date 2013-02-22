class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def confirmation(user)
    @user = user
    mail to: user.email, subject: "AppZone Marketplace Notification"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "AppZone Marketplace Notification"
  end

end
