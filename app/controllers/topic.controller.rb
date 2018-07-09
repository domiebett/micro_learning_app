require 'sinatra'
require 'slim'

require_relative '../models/category'
require_relative '../models/topic'
require_relative '../models/user'
require_relative '../models/user_topic'

class App < Sinatra::Application
  get '/topics/:category_name', auth: true do
    category = Category.find_by(name: params[:category_name])
    @topics = category.topics
    slim :"topic/view"
  end

  post '/topics', auth: true do
    user = current_user
    topic_names = params[:topics] || []

    if topic_names.empty?
      flash_warning 'You have not selected any topic'
      redirect "/topics/#{params[:category]}"
    end

    category = Category.find_by(name: params[:category])
    category.topics.each do |topic|
      user.topics.delete topic unless topic_names.include? topic.name
    end

    topic_names.each do |topic_name|
      topic = Topic.find_by(name: topic_name)
      user.topics << topic unless user.topics.include? topic
    end

    redirect '/'
  end
end
