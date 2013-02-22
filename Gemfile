source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'jquery-rails'
gem 'bcrypt-ruby', '~> 3.0.0', require: "bcrypt"
gem 'slim'
gem 'slim-rails'
gem 'simple_form'
gem 'has_draft', git: 'git://github.com/galulex/has_draft.git'
gem 'paperclip'
gem 'state_machine'
gem 'thin'
gem 'carmen-rails', '~> 1.0.0.beta3'
gem 'kaminari'
gem 'breadcrumbs_on_rails'
gem 'friendly_id'
gem 'sidekiq'
#gem 'sidekiq-mailer'
#gem 'thinking-sphinx'
gem 'acts_as_rateable'

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
  gem 'simplecov', :require => false
end

group :production do
  # gems specifically for Heroku go here
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem "pg"
end
