FactoryGirl.define do
  factory :product do
    association :company
    name Faker::Name.name
    image { fixture_file_upload('spec/support/product_images/impro-f.png', 'image/png') }
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

  factory :product_draft, class: ProductDraft do |p|
    product nil
    name Faker::Name.name
    image { fixture_file_upload('spec/support/product_images/impro-f.png', 'image/png') }
    summary Faker::Lorem.paragraph
    description Faker::Lorem.paragraphs
    features Faker::Lorem.paragraphs
    support Faker::Lorem.paragraph
  end
end
