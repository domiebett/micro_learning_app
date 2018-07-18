require 'sinatra/activerecord'

class Category < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :name, :description, presence: true
  validates :name, length: { minimum: 2 }
  validates :description, length: { minimum: 5 }

  has_many :topics, dependent: :destroy
end
