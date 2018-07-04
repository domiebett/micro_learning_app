require 'sinatra'
require 'slim'

class App < Sinatra::Application
  get '/', auth: true do
    slim :homepage
  end
end
