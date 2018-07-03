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
        flash[key] = value
      end
      flash[:password] = messages[:password_hash]

      session[:error_fields] = params
    end
  end

  helpers FlashHelper
end
