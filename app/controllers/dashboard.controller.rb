require 'sinatra'

class App < Sinatra::Application
  get '/dashboard' do
    redirect '/' if logged_in?
    slim :"general/dashboard"
  end
end
