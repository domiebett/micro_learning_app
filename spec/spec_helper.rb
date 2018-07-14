require 'rack/test'
require 'rspec'
require 'database_cleaner'
require 'factory_bot'
require 'simplecov'
require 'coveralls'
require 'webmock/rspec'
require 'news-api'

require_relative 'mocks/news_mock'
require_relative 'mocks/webhose_mock'
require_relative '../app/external_apis/webhose'

Coveralls.wear!

SimpleCov.start

WebMock.disable_net_connect!(allow_localhost: true)

ENV['RACK_ENV'] = 'test'

require File.expand_path '../main.rb', __dir__

module RSpecMixin
  include Rack::Test::Methods
  include FactoryBot::Syntax::Methods

  def app
    App
  end

  def session
    last_request.env['rack.session']
  end
end

RSpec.configure do |config|
  config.include RSpecMixin

  config.before(:suite) do
    FactoryBot.find_definitions
    DatabaseCleaner.strategy = :truncation, { except: %w[categories topics] }
  end

  config.before(:each) do
    DatabaseCleaner.start

    news_mock = NewsMock.new
    webhose_mock = WebHoseMock.new

    allow(News).to receive(:new).and_return news_mock
    allow(Webhose).to receive(:new).and_return webhose_mock

    @user = {
      first_name: 'Dom',
      last_name: 'Bett',
      email: 'bett@example.com',
      password: 'password'
    }

    @admin = {
        first_name: 'Dominic',
        last_name: 'Bett',
        email: 'dbett49@gmail.com',
        password: 'password'
    }
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
