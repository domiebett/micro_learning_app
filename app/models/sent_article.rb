require 'sinatra/activerecord'

class SentArticle < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
end
