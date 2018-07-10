require 'rufus-scheduler'
require_relative '../models/user'
require_relative '../models/sent_article'
require_relative '../models/topic'

scheduler = Rufus::Scheduler.new

scheduler.every '10s' do
  send_articles
end

# Sends articles to users who have topics selected
def send_articles
  users = User.all
  users.each(&:send_article)
end
