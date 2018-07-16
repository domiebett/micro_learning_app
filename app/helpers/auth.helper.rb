require 'sinatra'
require_relative '../models/user'

module Sinatra
  module AuthHelper
    # Checks if there is any logged in user
    def logged_in?
      !session[:user_id].nil?
    end

    # Gets the current user
    def current_user
      User.find(session[:user_id])
    end

    # Helps to validate login params
    def validate_login_params(email, password)
      errors = { email: [], password: [] }
      email ||= ''
      password ||= ''

      email_regexp = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      errors[:email] << 'the email is invalid' unless email =~ email_regexp
      errors[:email] << 'cannot be blank' if email.empty?
      errors[:password] << 'expects atleast 6 characters' if password.length < 6

      unless errors[:email].empty? && errors[:password].empty?
        flash_messages errors
        redirect '/signin'
      end
    end
  end

  helpers AuthHelper
end
