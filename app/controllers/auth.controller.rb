require 'sinatra'
require 'slim'
require 'sinatra/flash'

require_relative '../models/user'

class App < Sinatra::Application
  get '/signin' do
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
      flash_errors(@user.errors)
      redirect '/signup'
    end
  end

  private
  def flash_errors(errors)
    errors.messages.each do |key, value|
      flash[key] = value
    end
    flash[:password] = errors.messages[:password_hash]

    session[:error_fields] = params

    puts session[:error_fields]
  end
end
