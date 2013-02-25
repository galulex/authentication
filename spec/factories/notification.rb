# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    association :user
    notification_type :product_published
    data {{ company: Faker::Name.name, product: Faker::Name.name }}
  end
end
