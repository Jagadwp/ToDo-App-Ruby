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

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryBot::Syntax::Methods

  # shoulda-matchers setup
  Shoulda::Matchers.configure do |m|
    m.integrate do |with|
      with.test_framework :rspec
      with.library :active_record
      with.library :active_model
    end
  end

  # database cleaner
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end

  # factory bot
  config.before(:suite) do
    FactoryBot.find_definitions
  end
end

def app
  Padrino.application
end
