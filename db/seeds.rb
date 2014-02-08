require 'factory_girl_rails'
require 'csv'
include ActionDispatch::TestProcess

categories = CSV.parse(File.new("#{Rails.root}/db/seeds/categories.csv")).flatten.first
categories.strip.split(',').each do |category|
  Category.create(name: category)
end

admin = FactoryGirl.create(:admin, first_name: 'AppZone', last_name: 'Admin', email: 'admin@marketplace.com')
20.times do
  FactoryGirl.reload
  logo = File.new(Dir.glob(Rails.root + 'spec/support/company_logos/*').sample)
  user = FactoryGirl.create(:user, company: FactoryGirl.build(:company, logo: logo))
  rand(3).times do
    icon = File.new(Rails.root + Dir.glob('spec/support/company_logos/*').sample)
    image = File.new(Rails.root + Dir.glob('spec/support/product_images/*').sample)
    product = FactoryGirl.create(:product, company: user.company, icon: icon, image: image, status: 'published', category_ids: [Category.scoped.sample.id])
    puts product.name
    FactoryGirl.reload
  end
end
