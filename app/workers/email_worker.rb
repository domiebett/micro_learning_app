require 'sidekiq'
require_relative '../models/user'

class EmailWorker
  include Sidekiq::Worker

  def perform
    # users = User.all
    # users.each(&:send_article)
    puts "Boom Skya"
  end
end
