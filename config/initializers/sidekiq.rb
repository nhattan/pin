Sidekiq.configure_server do |config|
  config.redis = {url: "redis://#{ENV['REDIS_HOSTNAME']}:6379/0" }
end
