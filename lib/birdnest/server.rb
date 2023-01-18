# frozen_string_literal: true

require "sinatra/base"

module Birdnest
  class Server < Sinatra::Base
    get "/" do
      "hello world"
    end
  end
end
