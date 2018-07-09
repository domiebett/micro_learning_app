require 'sinatra'
require 'slim'

require_relative '../models/category'
require_relative '../models/topic'
require_relative '../models/user'
require_relative '../models/user_topic'

class App < Sinatra::Application
  get '/', auth: true do
    user = current_user
    @topics = user.topics || []
    redirect '/categories' if @topics.empty?
    slim :homepage
  end
end
