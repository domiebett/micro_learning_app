require 'sinatra'
require_relative '../models/user'

module Sinatra
  module AuthHelper
    def logged_in?
      !session[:user_id].nil?
    end

    def current_user
      User.find(session[:user_id])
    end
  end

  helpers AuthHelper
end
