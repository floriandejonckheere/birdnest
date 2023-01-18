# frozen_string_literal: true

require "http"
require "ox"
require "sidekiq"

module Birdnest
  module Jobs
    class Fetch
      include Sidekiq::Worker

      def perform
        response = HTTP.get("https://assignments.reaktor.com/birdnest/drones")

        return unless response.status.success?

        doc = Ox.load(response.to_s, mode: :hash)

        tags, *captures = doc.dig(:report, :capture)

        time = tags[:snapshotTimestamp]

        captures.each do |drone|
          x, y = drone[:drone].slice(:positionX, :positionY).values.map(&:to_d)

          # Check if the drone violates the NDZ
          d = Math.sqrt(((x - 250_000)**2) + ((y - 250_000)**2))

          # Skip if the drone is outside the NDZ
          next if d > 100_000

          # Query pilot information
          response = HTTP.get("https://assignments.reaktor.com/birdnest/pilots/#{drone.dig(:drone, :serialNumber)}")

          next unless response.status.success?

          doc = JSON.parse(response.to_s, symbolize_names: true)

          id, first_name, last_name, phone, email = doc.slice(:pilotId, :firstName, :lastName, :phoneNumber, :email).values

          # Store pilot information
          Birdnest.redis.call("HSET", "pilot:#{id}", "first_name", first_name, "last_name", last_name, "phone", phone, "email", email)

          # Previous distance
          distance = Birdnest.redis.call("HGET", "pilot:#{id}", "distance")&.to_d

          # Update distance if it's less than the previous one
          Birdnest.redis.call("HSET", "pilot:#{id}", "distance", d, "last_seen_at", time)

          # Expire information in 10 minutes
          Birdnest.redis.call("EXPIRE", "pilot:#{id}", 600)
        end
      end
    end
  end
end
