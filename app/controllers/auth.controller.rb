require 'sinatra'
require 'slim'

class App < Sinatra::Application
  get '/login' do
    slim :"auth/login"
  end

  get '/register' do
    slim :"auth/register"
  end
end
