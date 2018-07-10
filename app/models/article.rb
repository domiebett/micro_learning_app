require 'sinatra/activerecord'

class Article < ActiveRecord::Base
  validates :title, uniqueness: true
  validates :title, :description, :url, presence: true

  belongs_to :topic
end