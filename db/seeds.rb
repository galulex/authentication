require 'factory_girl_rails'
include ActionDispatch::TestProcess

[Company, Product, User].each(&:delete_all)

admin = FactoryGirl.create(:admin, first_name: 'Super', last_name: 'Admin', email: 'marketplace@mail.com')
20.times do
  FactoryGirl.reload
  logo = File.new(Dir.glob(Rails.root + 'spec/support/company_logos/*').sample)
  user = FactoryGirl.create(:user, company: FactoryGirl.build(:company, logo: logo))
  rand(3).times do
    icon = File.new(Rails.root + Dir.glob('spec/support/company_logos/*').sample)
    image = File.new(Rails.root + Dir.glob('spec/support/product_images/*').sample)
    product = FactoryGirl.create(:product, company: user.company, icon: icon, image: image, status: 'published')
    puts product.name
    FactoryGirl.reload
  end
end
