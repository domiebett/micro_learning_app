require 'sinatra/activerecord'

class Category < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :name, presence: true
  validates :name, length: { minimum: 2 }

  has_many :topics
end