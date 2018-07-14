require 'rufus-scheduler'
require_relative '../models/user'
require_relative '../models/sent_article'
require_relative '../models/topic'

scheduler = Rufus::Scheduler.new

scheduler.cron('0 7 * * *') { send_articles }

def send_articles
  users = User.all
  users.each(&:send_article)
end
