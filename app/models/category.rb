require 'sinatra/activerecord'

class Category < ActiveRecord::Base
  validates :name, uniqueness: true

  has_many :topics
end