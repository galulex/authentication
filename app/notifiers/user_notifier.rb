class UserNotifier
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(action, params = {})
    send(action, params)
  end

  def confirmation(params)
    user = User.find(params['user_id'])
    UserMailer.send(:confirmation, user).deliver
  end

  def password_reset(params)
    user = User.find(params['user_id'])
    UserMailer.send(:password_reset, user).deliver
  end

  def invite(params)
    users = User.where(id: params['user_ids'])
    admin = User.find(params['admin_id'])
    users.each do |user|
      UserMailer.send(:invite, user, admin).deliver
    end
  end

  def admin_invite(params)
    user = User.find(params['user_id'])
    UserMailer.send(:admin_invite, user).deliver
  end

end
