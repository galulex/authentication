FactoryGirl.define do
  factory :product do
    association :company
    name Faker::Name.name
    summary Faker::Lorem.paragraph
    description Faker::Lorem.paragraphs
    features Faker::Lorem.paragraphs
    support Faker::Lorem.paragraph
  end

  factory :product_review do
    association :product
    association :user
    title Faker::Name.name
    review Faker::Lorem.paragraph
  end

  factory :product_rating do
    association :product
    association :user
    score 1
  end
end
