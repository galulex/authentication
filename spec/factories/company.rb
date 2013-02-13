FactoryGirl.define do
  factory :company do |c|
    c.name  Faker::Company.name
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

end
