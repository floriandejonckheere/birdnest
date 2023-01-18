# frozen_string_literal: true

require "sinatra/base"

module Birdnest
  class Server < Sinatra::Base
    get "/" do
      "hello world"
    end

    get "/pilots" do
      content_type :json

      Birdnest.redis.call("KEYS", "pilot:*").map do |key|
        Birdnest.redis.call("HGETALL", key)
      end.to_json
    end
  end
end
