require 'rubygems'
require 'bundler'

Bundler.require

require 'candies'

# Candies.redis = ENV['REDISTOGO_URL']

run Candies::Server.new