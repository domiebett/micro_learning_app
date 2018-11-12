require 'sinatra'
require 'slim'

require_relative '../models/user'

class App < Sinatra::Application

  get '/signin' do
    redirect '/' if logged_in?
    @inputs = %i[email password]
    slim :"auth/login"
  end

  get '/signup' do
    redirect '/' if logged_in?
    @inputs = %i[first_name last_name email password]
    slim :"auth/register"
  end

  get '/logout' do
    session[:user_id] = nil
    flash_notice 'You have logged out successfully'
    redirect '/dashboard'
  end

  post '/signup' do
    @user = User.new(accept_params(params, :first_name, :last_name, :email))
    @user.password = params[:password] || ''
    @user.is_admin = true if params[:email] == 'dbett49@gmail.com'

    if @user.save
      session[:user_id] = @user.id
      session[:error_fields] = nil
      flash_notice 'You successfully signed up'
      redirect '/'
    else
      flash_messages(@user.errors.messages)
      redirect '/signup'
    end
  end

  post '/signin' do
    validate_login_params(params[:email], params[:password])
    @user = User.find_by(email: params[:email])

    unless @user.nil?
      if @user.password == params[:password]
        session[:user_id] = @user.id
        flash_notice 'You successfully signed in'
        redirect '/'
      end
    end

    flash_warning 'You entered wrong email or password'
    redirect '/signin'
  end
end
