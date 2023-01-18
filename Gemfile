# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 3.2"

# ActiveSupport
gem "activesupport"

# Simple low level client for Redis 6+
gem "redis-client"

# Code loader
gem "zeitwerk"

group :development do
  # Debugger
  gem "debug", require: false

  # Console
  gem "irb", require: false
end
