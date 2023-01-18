# frozen_string_literal: true

require "logger"

require "active_support/all"
require "redis-client"
require "zeitwerk"

require "debug" if ENV["ENV"] == "development"

module Birdnest
  class << self
    attr_reader :loader

    def root
      @root ||= Pathname.new(File.expand_path(File.join("..", ".."), __FILE__))
    end

    def logger
      @logger ||= Logger.new
    end

    def config
      @config ||= Configuration.new
    end

    def redis
      @redis ||= Redis.new
    end

    def setup
      @loader = Zeitwerk::Loader.for_gem

      # Register inflections
      require root.join("config/inflections.rb")

      # Set up code loader
      loader.enable_reloading
      loader.setup
      loader.eager_load
    end
  end
end

def reload!
  Birdnest.loader.reload
end

Birdnest.setup
