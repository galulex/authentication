FactoryGirl.define do
  factory :not_activated_user, class: User::Partner do |u|
    u.association :company
    u.role_id User::ROLES.index(User::ADMIN)
    u.first_name Faker::Name.first_name
    u.last_name Faker::Name.last_name
    u.email Faker::Internet.email
    u.auth_token SecureRandom.urlsafe_base64
    u.password 'P@ssword'
    u.password_confirmation 'P@ssword'
  end

  factory :user, parent: :not_activated_user do |u|
    after(:create) { |u| u.update_attribute(:token, nil) }
  end

  factory :admin, class: User::Tenant, parent: :user do |u|
  end

end
