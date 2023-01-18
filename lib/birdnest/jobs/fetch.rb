# frozen_string_literal: true

module Birdnest
  module Jobs
    class Fetch
      include Sidekiq::Worker

      def perform
        "Fetching!"
      end
    end
  end
end
