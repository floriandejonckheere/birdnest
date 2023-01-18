# frozen_string_literal: true

require "English"
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

      # Set up code loader
      loader.enable_reloading
      loader.setup
      loader.eager_load

      # Run initializers
      Dir[root.join("config/initializers/*.rb")].each { |f| require f }
    end
  end
end

def reload!
  Birdnest.loader.reload
end

Birdnest.setup
