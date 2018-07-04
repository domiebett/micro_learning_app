require 'sinatra'
require 'sinatra/flash'
require_relative '../models/user'

module Sinatra
  module FlashHelper
    def flash_notice(notification)
      flash[:notice] = notification
    end

    def flash_warning(warning)
      flash[:warning] = warning
    end

    def flash_messages(messages)
      messages.each do |key, value|
        flash[:password] = value if key == :password_hash
        flash[key] = value
      end

      session[:error_fields] = params
    end
  end

  helpers FlashHelper
end
