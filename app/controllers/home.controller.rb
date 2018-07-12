require 'sinatra'
require 'slim'

require_relative '../models/category'
require_relative '../models/topic'
require_relative '../models/user'
require_relative '../models/user_topic'
require_relative '../models/article'
require_relative '../external_apis/news_api'

class App < Sinatra::Application
  get '/', auth: true do
    user = current_user
    @topics = user.topics || []

    @articles = {}
    @topics.each do |topic|
      @articles.store(topic.name.to_sym, topic.articles ? topic.articles : [])
    end

    slim :homepage
  end
end
