if ENV['REDIS_CART_URL']
  $redis = Redis.new(url: ENV['REDIS_CART_URL'])
end
