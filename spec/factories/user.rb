FactoryGirl.define do
  factory :user, class: User::Partner do |u|
    u.association :company
    u.role_id User::ROLES.invert[ADMIN]
    u.first_name Faker::Name.first_name
    u.last_name Faker::Name.last_name
    u.email Faker::Internet.email
    u.auth_token SecureRandom.urlsafe_base64
    u.password 'P@ssword'
    u.password_confirmation 'P@ssword'

    after(:create) { |u| u.update_attribute(:token, nil) }
  end

  factory :not_activated_user, parent: :user do |u|
    u.token SecureRandom.urlsafe_base64
  end

  factory :admin, class: User::Tenant, parent: :user do |u|
  end

end
