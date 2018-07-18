require 'rufus-scheduler'
require_relative '../models/user'
require_relative '../models/sent_article'
require_relative '../models/topic'

scheduler = Rufus::Scheduler.new

scheduler.cron('00 07 * * *') do
  send_articles
end

def send_articles
  users = User.all
  users.each(&:send_article)
end
