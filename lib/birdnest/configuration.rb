# frozen_string_literal: true

module Birdnest
  class Configuration
    def redis_url
      ENV.fetch("REDIS_URL", "redis://redis:6379/0")
    end

    def redis_pool
      ENV.fetch("REDIS_POOL", 5).to_i
    end
  end
end
