require 'sinatra'
require 'slim'
require 'sinatra/flash'

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
      flash_messages warning: 'You entered wrong email or password'
      redirect '/signin'
    end
  end

  private
  def flash_messages(error_messages)
    error_messages.each do |key, value|
      flash[key] = value
    end
    flash[:password] = error_messages[:password_hash]

    session[:error_fields] = params
  end
end
