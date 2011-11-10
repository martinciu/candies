require 'rubygems'
require 'bundler'
Bundler.setup(:default, :test)
Bundler.require(:default, :test)

require 'minitest/spec'
require 'minitest/autorun'
require 'turn'
require 'mocha'
require 'rack/test'
require 'timecop'

dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + '/../lib'
$TESTING = true

