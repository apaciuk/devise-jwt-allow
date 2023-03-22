if ENV['REDIS_SIDEKIQ_URL']
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_SIDEKIQ_URL'], network_timeout: 5 }
  end
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_SIDEKIQ_URL'], network_timeout: 5 }
  end
end
