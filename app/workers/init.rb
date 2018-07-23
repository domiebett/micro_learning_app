require 'sidekiq'
require 'sidekiq-cron'

require_relative 'email_worker'

Sidekiq.configure_client do |config|
  config.redis = { db: 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { db: 1 }
end

Sidekiq::Cron::Job.create(
  name: 'Send Emails every day',
  cron: '*/1 * * * *',
  class: EmailWorker
)
