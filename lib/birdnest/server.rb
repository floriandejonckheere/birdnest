# frozen_string_literal: true

require "sinatra/base"

module Birdnest
  class Server < Sinatra::Base
    get "/" do
      erb :index, locals: { pilots: pilots.sort_by { |pilot| pilot[:last_name] } }
    end

    private

    def pilots
      Birdnest.redis.call("KEYS", "pilot:*").map do |key|
        Birdnest.redis.call("HGETALL", key).symbolize_keys
      end
    end
  end
end
