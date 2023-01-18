# frozen_string_literal: true

require "sidekiq"

module Birdnest
  module Jobs
    class Fetch
      include Sidekiq::Worker

      def perform
        puts "Fetching!"
      end
    end
  end
end
