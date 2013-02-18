FactoryGirl.define do
  factory :company do |c|
    c.name  Faker::Company.name
    c.logo { fixture_file_upload('spec/support/company_logos/impro.png', 'image/png') }
    c.synopsis Faker::Lorem.paragraph
    c.description Faker::Lorem.paragraphs
    c.website Faker::Internet.http_url
    c.status :approved
    c.street1 Faker::Address.street_address
    c.country Faker::AddressUK.country
    c.state Faker::AddressUS.state_abbr
    c.city Faker::Address.city
    c.postal_code Faker::AddressUS.zip_code
    c.phone Faker::PhoneNumber.phone_number
  end

  factory :company_draft, class: Company::Draft, parent: :company do

  end

end
