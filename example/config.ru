require 'rubygems'
require 'bundler'

Bundler.require

require 'tracker'

# Tracker.redis = ENV['REDISTOGO_URL']

run Tracker::Server.new