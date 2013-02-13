require 'factory_girl_rails'

[Company, Product, User].each(&:delete_all)

admin = FactoryGirl.create(:admin, first_name: 'AppZone', last_name: 'Admin', email: 'marketplace@partnerpedia.com')
puts admin.name
9.times do |i|
  FactoryGirl.reload
  logo = File.new(Dir.glob('spec/support/company_logos/*')[i])
  user = FactoryGirl.create(:user, company: FactoryGirl.build(:company, logo: logo))
  puts user.name
  rand(3).times do
    icon = File.new(Dir.glob('spec/support/company_logos/*')[i])
    image = File.new(Dir.glob('spec/support/product_images/*')[i])
    product = FactoryGirl.create(:product, company: user.company, icon: icon, image: image)
    puts product.name
  end
end
