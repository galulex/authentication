require 'factory_girl_rails'

[Company, Product, User].each(&:delete_all)

admin = FactoryGirl.create(:admin, first_name: 'AppZone', last_name: 'Admin', email: 'marketplace@partnerpedia.com')
puts admin.name
10.times do
  FactoryGirl.reload
  user = FactoryGirl.create(:user)
  puts user.name
  rand(3).times do
    product = FactoryGirl.create(:product, company: user.company)
    puts product.name
  end
end
