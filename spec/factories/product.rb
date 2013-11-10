FactoryGirl.define do
  factory :product do
    association :company
    name Faker::Name.name
    version 1
    phone_form_factor true
    software { fixture_file_upload('spec/support/softwares/client_software.apk', 'file/apk') }
    image { fixture_file_upload('spec/support/product_images/impro-f.png', 'image/png') }
    icon { fixture_file_upload('spec/support/company_logos/evernote.png', 'image/png') }
    summary Faker::Lorem.paragraph
    description Faker::Lorem.paragraphs
    features Faker::Lorem.paragraphs
    support Faker::Lorem.paragraph
  end

  factory :product_draft, class: ProductDraft do |p|
    product nil
    name Faker::Name.name
    version 1
    phone_form_factor true
    software { fixture_file_upload('spec/support/softwares/client_software.apk', 'file/apk') }
    image { fixture_file_upload('spec/support/product_images/impro-f.png', 'image/png') }
    icon { fixture_file_upload('spec/support/company_logos/evernote.png', 'image/png') }
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

  factory :product_pricing do
    from 1
    to 10
    price 9.99
  end

  factory :product_image do
    file { fixture_file_upload('spec/support/product_images/impro-f.png', 'image/png') }
  end

  factory :product_resource do
    resourceable nil
    title Faker::Name.name
    file { fixture_file_upload('spec/support/product_images/impro-f.png', 'image/png') }
  end

  factory :product_video do
    videoable nil
    url "http://youtu.be/zvHTX2C4rKc"
  end
end
