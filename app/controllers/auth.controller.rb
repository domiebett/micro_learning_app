require 'sinatra'
require 'slim'

require_relative '../models/user'

class App < Sinatra::Application
  get '/signin' do
    @inputs = %i[email password]
    slim :"auth/login"
  end

  get '/signup' do
    @inputs = %i[first_name last_name email password]
    slim :"auth/register"
  end

  get '/logout' do
    session[:user_id] = nil
    flash_notice 'You have logged out successfully'
    redirect '/dashboard'
  end

  post '/signup' do
    @user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email]
    )
    @user.password = params[:password] || ''

    if @user.save
      session[:user_id] = @user.id
      session[:error_fields] = nil
      redirect '/'
    else
      flash_messages(@user.errors.messages)
      redirect '/signup'
    end
  end

  post '/signin' do
    @user = User.find_by(email: params[:email])

    if @user.nil?
      messages = ['Email is not registered. Please sign up']
      flash_messages email: messages
      redirect '/signin'
    end

    if @user.password == params[:password]
      session[:user_id] = @user.id
      redirect '/'
    else
      flash_warning 'You entered wrong email or password'
      redirect '/signin'
    end
  end
end
