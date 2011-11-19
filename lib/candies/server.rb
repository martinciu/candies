require "candies/server/base"
require "candies/server/json"
require "candies/server/gif"

module Candies
  module Server
    def self.new
      Rack::Builder.new do
        use Rack::ContentLength
        run Candies::Server::Base.new(:gif => Candies::Server::Gif.new, :json => Candies::Server::Json.new)
      end
    end
  end
end
