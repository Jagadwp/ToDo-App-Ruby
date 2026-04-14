# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

ENV['RACK_ENV'] = 'test'

require File.expand_path('../config/boot', __dir__)
require 'rspec'
require 'rspec/padrino'
require 'rack/test'
require 'factory_bot'
require 'faker'
require 'database_cleaner/active_record'
require 'shoulda/matchers'
require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'webdrivers'

Capybara.configure do |config|
  config.app              = Padrino.application
  config.server           = :webrick
  config.default_driver   = :selenium_chrome
  config.javascript_driver = :selenium_chrome
  config.app_host         = 'http://127.0.0.1:3001'
  config.server_port      = 3001
end

Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  # options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1280,800')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryBot::Syntax::Methods

  Shoulda::Matchers.configure do |m|
    m.integrate do |with|
      with.test_framework :rspec
      with.library :active_record
      with.library :active_model
    end
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    FactoryBot.find_definitions
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def app
  Padrino.application
end
