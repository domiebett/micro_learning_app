require 'sinatra/activerecord'
require_relative '../external_apis/news_api'

class Topic < ActiveRecord::Base
  validates :name, uniqueness: true

  belongs_to :category
  has_many :user_topics
  has_many :users, through: :user_topics
  has_many :articles

  def fetch_articles
    news_api = NewsApi.new('dca162428fd344318bb51036cbe37695')
    api_articles = news_api.fetch_articles("#{name} #{category.name}")

    api_articles.each do |api_article|

      next unless articles.find_by(title: api_article.title).nil?

      articles.create(
        title: api_article.title,
        description: api_article.description,
        author: api_article.author,
        url: api_article.url
      )
    end
  end
end
