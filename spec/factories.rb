FactoryGirl.define do
  factory :user do |u|
    u.email Faker::Internet.email
    u.token SecureRandom.urlsafe_base64
    u.auth_token SecureRandom.urlsafe_base64
    u.password 'Password2012'
    u.password_confirmation 'Password2012'
  end
end
