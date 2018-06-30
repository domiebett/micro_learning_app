require 'sinatra'

class App < Sinatra::Application
  get '/dashboard' do
    slim :"general/dashboard"
  end
end
