class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :password, :password_confirmation

  validates :password, :presence => true
  validates :email, :presence => true,
                    :length => { :minimum => 3, :maximum => 254, :allow_blank => true },
                    :uniqueness => true,
                    :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_blank => true }
  
  before_create { generate_token(:auth_token); generate_token(:token) }
  after_create :send_confirmation


  def activate
    self.update_attribute(:token, nil)
  end

  def activated?
    token.nil?
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_confirmation
    UserMailer.confirmation(self).deliver
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save
    UserMailer.password_reset(self).deliver
  end

end
