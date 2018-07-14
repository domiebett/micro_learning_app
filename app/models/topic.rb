require 'sinatra/activerecord'
require_relative '../external_apis/news_api'
require_relative '../external_apis/webhose'

class Topic < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :name, presence: true
  validates :name, length: { minimum: 2 }

  belongs_to :category
  has_many :user_topics
  has_many :users, through: :user_topics
  has_many :articles

  def fetch_articles
    fetched_articles = []
    news_api_thread = Thread.new do
      news_api = NewsApi.new
      api_articles = news_api.fetch_articles("#{name} #{category.name}")
      fetched_articles << api_articles
    end

    webhose_thread = Thread.new do
      webhose = Webhose.new
      api_articles = webhose.fetch_articles("#{name} #{category.name}")
      fetched_articles << api_articles
    end

    news_api_thread.join
    webhose_thread.join

    save_articles(fetched_articles.flatten!)
  end

  def save_articles(api_articles)
    api_articles.each do |api_article|
      next unless articles.find_by(title: api_article['title']).nil?

      articles.create(api_article)
    end
  end
end
