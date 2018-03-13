Rails.application.config.cache_store = :redis_store, {
  host: ENV['redis_host'],
  port: ENV['redis_port'],
  db: ENV['redis_db'],
  namespace: ENV['redis_namespace']
}
