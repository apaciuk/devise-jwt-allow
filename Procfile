web: bundle exec rails server -p 4000
worker: bundle exec sidekiq -c 1 -q $REDIS_QUEUE_DEFAULT -q $REDIS_QUEUE_MAILERS
