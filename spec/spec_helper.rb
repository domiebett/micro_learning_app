require 'rack/test'
require 'rspec'
require 'database_cleaner'
require 'factory_bot'
require 'simplecov'
require 'coveralls'

Coveralls.wear!

ENV['RACK_ENV'] = 'test'

require File.expand_path '../main.rb', __dir__

module RSpecMixin
  include Rack::Test::Methods
  include FactoryBot::Syntax::Methods
  def app
    App
  end
  SimpleCov.start
end

RSpec.configure do |config|
  config.include RSpecMixin

  config.before(:suite) do
    FactoryBot.find_definitions
    DatabaseCleaner.strategy = :truncation, {except: %w[categories topics] }
  end

  config.before(:each) do
    DatabaseCleaner.start
    @user = {
      first_name: 'Dominic',
      last_name: 'Bett',
      email: 'bett@example.com',
      password: 'password'
    }
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
