FactoryGirl.define do
  factory :company do |c|
    c.name  Faker::Company.name
    c.synopsis Faker::Lorem.paragraph
    c.description Faker::Lorem.paragraphs
    c.website Faker::Internet.url
    c.status :approved
    c.street1 Faker::Address.street_address
    c.country Faker::Address.country
    c.state Faker::Address.state_abbr
    c.city Faker::Address.city
    c.postal_code Faker::Address.zip_code
    c.phone Faker::PhoneNumber.cell_phone
  end

end
