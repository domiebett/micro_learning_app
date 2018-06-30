require 'rack/test'
require 'rspec'
require 'database_cleaner'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../main.rb', __dir__

module RSpecMixin
  include Rack::Test::Methods
  def app
    App
  end
end

RSpec.configure do |config|

  config.include RSpecMixin

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
