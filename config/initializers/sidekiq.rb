# frozen_string_literal: true

# Run embedded sidekiq only in main process
return unless $PROGRAM_NAME == "bin/birdnest"

require "sidekiq"
require "sidekiq-scheduler"

sidekiq = Sidekiq.configure_embed do |config|
  config.logger.level = :debug
  config.queues = ["default"]
  config.concurrency = 1
  config.redis = { url: Birdnest.config.redis_url, size: Birdnest.config.redis_pool }

  Thread.new do
    loop do
      Birdnest::Jobs::Fetch.perform_async

      sleep 5
    end
  end
end


sidekiq.run
