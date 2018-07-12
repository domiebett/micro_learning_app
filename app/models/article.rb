require 'sinatra/activerecord'

class Article < ActiveRecord::Base
  validates :title, uniqueness: true
  validates :title, :description, :url, presence: true

  belongs_to :topic
  has_many :sent_articles
end
