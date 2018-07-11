require 'sinatra'
require 'slim'
require_relative 'app/helpers/init'

class App < Sinatra::Application
  enable :sessions

  set(:auth) do |_condition|
    condition do
      if logged_in?
        @user = current_user
      else
        redirect '/signin'
      end
    end
  end

  set(:admin) do |condition|
    condition do
      halt 401 unless current_user.admin?
    end
  end
end

require_relative 'app/controllers/init'
