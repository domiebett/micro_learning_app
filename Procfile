web: bundle exec thin -R config.ru start -p $PORT
worker: bundle exec sidekiq -e production -C config/sidekiq.yml -r ./main.rb
