require 'sinatra/activerecord'

class UserTopic < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
end