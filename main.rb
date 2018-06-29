require 'sinatra'
require 'slim'
require_relative 'app/helpers/html.helper'

class App < Sinatra::Application

  enable :sessions

  get '/' do
    slim :homepage
  end

end

require_relative 'app/controllers/init'
