require 'sinatra'
require_relative 'app/helpers/html.helper'

class App < Sinatra::Application

  enable :sessions

end

require_relative 'app/controllers/init'
