source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'jquery-rails'
gem 'bcrypt-ruby', '~> 3.0.0', require: "bcrypt"
gem 'slim' # A lightweight templating engine
gem 'slim-rails' # A lightweight templating engine
gem 'simple_form' # SimpleForm - Rails forms made easy
gem 'mini_magick' # Mini replacement for RMagick
gem 'carrierwave' # Classier solution for file uploads
gem 'state_machine' # Adds support for creating state machines for attributes
gem 'thin' # A very fast & simple Ruby web server
gem 'carmen-rails', '~> 1.0.0.beta3' # A repository of geographic regions
gem 'kaminari' # A Scope & Engine based, clean, powerful, customizable paginator
gem 'breadcrumbs_on_rails' # Plugin for creating and managing a breadcrumb navigation
gem 'friendly_id' # Allows you to create pretty URL’s
gem 'sidekiq' # Simple, efficient message processing
gem 'sunspot_rails' # Solr-powered search

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-sass'
  gem 'font-awesome-sass-rails'
  gem 'bootstrap-datepicker-rails'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'letter_opener'
  gem 'mysql2'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'shoulda-matchers'
  gem 'quiet_assets'
  gem 'simplecov', require: false
  gem 'fuubar'
end

group :production do
  # gems specifically for Heroku go here
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem "pg"
end
