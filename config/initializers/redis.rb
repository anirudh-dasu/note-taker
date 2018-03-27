uri = ENV['REDIS_URL'] || 'redis://localhost:6379/0/notetaker-cache'

Rails.application.config.cache_store = :redis_store, uri
