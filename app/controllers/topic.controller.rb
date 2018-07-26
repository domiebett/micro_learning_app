require 'sinatra'
require 'slim'

require_relative '../models/category'
require_relative '../models/topic'
require_relative '../models/user'
require_relative '../models/user_topic'

class App < Sinatra::Application
  get '/topics/:category_name', auth: true do
    @category = Category.find_by(name: params[:category_name])
    @topics = @category.topics
    slim :"topic/view"
  end

  put '/topics/user', auth: true do
    user = current_user
    topic_names = params[:topics] || []

    category = Category.find_by(name: params[:category_name])
    category.topics.each do |topic|
      user.topics.delete topic unless topic_names.include? topic.name
    end

    fetch_articles_thread = nil

    topic_names.each do |topic_name|
      topic = Topic.find_by(name: topic_name)

      fetch_articles_thread = Thread.new do
        topic.fetch_articles
      end

      user.topics << topic unless user.topics.include? topic
    end

    fetch_articles_thread.join unless fetch_articles_thread.nil?

    redirect '/'
  end

  post '/topics', auth: true, admin: true do
    @category = Category.find_by(name: params[:category_name])
    @topic = @category.topics.build(name: params[:name])

    if @topic.save
      flash_notice 'Topic added successfully'
    else
      flash_warning 'You did not enter a valid topic'
    end

    redirect "/topics/#{@category.name}"
  end

  delete '/topics/user/:topic_id', auth: true do
    user = current_user
    topic = Topic.find_by(id: params[:topic_id])

    user.topics.delete topic

    redirect '/'
  end

  delete '/topics/:topic_id', auth: true, admin: true do
    topic = Topic.find_by(id: params[:topic_id])

    category_name = topic.category.name

    flash_notice "Topic has been deleted" if topic.destroy

    redirect "/topics/#{category_name}"
  end
end
