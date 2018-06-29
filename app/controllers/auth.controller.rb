require 'sinatra'
require 'slim'

require_relative '../models/user'

class App < Sinatra::Application
  get '/signin' do
    slim :"auth/login"
  end

  get '/signup' do
    slim :"auth/register"
  end

  post '/signup' do

    @user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email]
    )
    @user.password = params[:password]

    if @user.save
      redirect '/'
    else
      puts @user.errors.full_messages
      redirect '/signup'
    end
  end
end
