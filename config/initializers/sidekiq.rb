# frozen_string_literal: true

# Run embedded sidekiq only in main process
return unless $PROGRAM_NAME == "bin/birdnest"

require "sidekiq"

sidekiq = Sidekiq.configure_embed do |config|
  config.logger.level = :debug
  config.queues = %w(default)
  config.concurrency = 1
  config.redis = { url: Birdnest.config.redis_url, size: Birdnest.config.redis_pool }
end

sidekiq.run
