class User < ActiveRecord::Base

  EMPLOYEE = 'employee'
  ADMIN = 'admin'
  SALES_REP = 'sales_rep'
  SALES_MANAGER = 'sales_manager'
  MARKETER = 'marketer'

  ROLES = { 1 => ADMIN, 2 => SALES_REP, 3 => SALES_MANAGER, 4 => MARKETER,  5 => EMPLOYEE }

  belongs_to :company

  attr_accessor :password, :password_confirmation
  attr_accessible :company_attributes, :email, :job, :first_name, :last_name, :password, :password_confirmation
  accepts_nested_attributes_for :company

  validates :first_name, :last_name, presence: true
  validates :email, presence: true,
                    length: { minimum: 3, maximum: 254, allow_blank: true },
                    uniqueness: true,
                    format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, allow_blank: true }

  validates :password, presence: true, if: :validate_password?

  before_create { generate_token(:auth_token); generate_token(:token) }

  def activate
    self.update_attribute(:token, nil)
  end

  def activated?
    token.nil?
  end

  def reset_password
    generate_token(:password_reset_token)
    self.update_attribute(:password_reset_sent_at, Time.zone.now)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def role
    ROLES[role_id]
  end

  def admin?
    role == ADMIN
  end

  def tenant?
    is_a?(User::Tenant)
  end

  def authenticate(unencrypted_password)
    BCrypt::Password.new(password_digest) == unencrypted_password && self
  end

  def password=(unencrypted_password)
    unless unencrypted_password.blank?
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(unencrypted_password, cost: BCrypt::Engine::DEFAULT_COST)
    end
  end

  private

  def validate_password?
    self.password || self.password_confirmation
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end
