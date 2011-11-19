module Candies
  module Server
    class Base
      attr_accessor :request, :id, :responders

      def initialize(responders = {})
        @responders = responders
      end

      def call(env)
        @request = Rack::Request.new(env)
        @responders.fetch(format) {@responders[:json]}.call(env)
      end

      protected
        def format
          @request.path.split(".").last.to_sym
        end

        def tracker
          @request.path.match(/^\/(\w+)\.?(\w+$)?/)[1]
        end

        def id
          @id ||= @request.params.delete("id")        
        end

        def status
          200
        end

    end  
  end
end
