FactoryGirl.define do
  factory :user do |u|
    u.association :company
    u.type User::Partner
    u.role_id User::ROLES.invert[ADMIN]
    u.first_name Faker::Name.first_name
    u.last_name Faker::Name.last_name
    u.email Faker::Internet.email
    u.auth_token SecureRandom.urlsafe_base64
    u.password 'P@ssword'
    u.password_confirmation 'P@ssword'
  end

  factory :not_activated_user, parent: :user do |u|
    u.token SecureRandom.urlsafe_base64
  end

  factory :admin, parent: :user do |u|
    u.type User::Tenant
  end

end
