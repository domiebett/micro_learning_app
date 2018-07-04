require 'rack/test'
require 'rspec'
require 'database_cleaner'
require 'factory_bot'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../main.rb', __dir__

module RSpecMixin
  include Rack::Test::Methods
  include FactoryBot::Syntax::Methods
  def app
    App
  end
end

RSpec.configure do |config|

  config.include RSpecMixin

  config.before(:suite) do
    FactoryBot.find_definitions
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
