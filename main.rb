require 'sinatra'
require 'slim'
require_relative 'app/helpers/init'

class App < Sinatra::Application

  enable :sessions

  get '/' do
    slim :homepage
  end

end

require_relative 'app/controllers/init'
