FactoryGirl.define do
  factory :product do |p|
    p.association :company
    p.name Faker::Name.name
    p.summary Faker::Lorem.paragraph
    p.description Faker::Lorem.paragraphs
    p.features Faker::Lorem.paragraphs
    p.support Faker::Lorem.paragraph
  end

  factory :product_review do |r|
    r.association :product
    r.association :user
    r.title Faker::Name.name
    r.review Faker::Lorem.paragraph
  end

end
