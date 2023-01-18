# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 3.2"

# ActiveSupport
gem "activesupport", "~> 7.0"

# Simple low level client for Redis 6+
gem "redis-client", "~> 0.12"

# Asynchronous job scheduler
gem "sidekiq", "~> 7.0"
gem "sidekiq-scheduler"

# Simple web framework
gem "sinatra", "~> 3.0"

# Rack application server
gem "webrick", "~> 1.7"

# Code loader
gem "zeitwerk"

group :development, :test do
  # Linter
  gem "rubocop"
  gem "rubocop-performance"
end

group :development do
  # Debugger
  gem "debug", require: false

  # Console
  gem "irb", require: false
end
