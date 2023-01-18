# frozen_string_literal: true

module Birdnest
  class Redis
    delegate_missing_to :redis

    private

    def redis
      @redis ||= config.new_pool(timeout: 0.5, size: Birdnest.config.redis_pool)
    end

    def config
      @config ||= RedisClient.config(url: Birdnest.config.redis_url)
    end
  end
end
