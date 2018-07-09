require 'sinatra/activerecord'

class Topic < ActiveRecord::Base
  validates :name, uniqueness: true

  belongs_to :category
  has_many :user_topics
  has_many :users, through: :user_topics
end
