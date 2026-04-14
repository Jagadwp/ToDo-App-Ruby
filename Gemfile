# frozen_string_literal: true

source 'https://rubygems.org'

# Padrino supports Ruby version 2.2.2 and later
# ruby '2.7.8'

# Distribute your app as a gem
# gemspec

# Server requirements
gem 'webrick'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'activerecord', '>= 3.1', require: 'active_record'
gem 'pg'
gem 'slim'

# Test requirements

# Padrino Stable Gem
gem 'padrino', '0.16.1'

group :development do
  gem 'byebug'
  gem 'rack-livereload'
  gem 'guard'
  gem 'guard-livereload'
end

group :test do
  gem 'rspec'
  gem 'rspec-padrino'
  gem 'rack-test'
  gem 'factory_bot'
  gem 'faker'
  gem 'database_cleaner-active_record'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'webrick'
end

# Or Padrino Edge
# gem 'padrino', github: 'padrino/padrino-framework'

# Or Individual Gems
# %w(core support gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.16.1'
# end
