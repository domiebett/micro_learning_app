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

    @articles = @topics.map(&:articles)
    @articles.flatten! unless @articles.empty?
    @recommended_article = @articles.sample
    @sent_articles = user.sent_articles.map(&:article)

    slim :homepage
  end
end
