module Candies
  module Server
    class Gif < Base

      def call(env)
        @request = Rack::Request.new(env)
        Candies.redis.set(key, @request.params.to_json) if !id.nil?
        [status, headers, body]
      end

      protected
        def headers
          {
            "Content-Type"   => "image/gif", 
            "Cache-Control"  => "no-store, no-cache, must-revalidate, private",
            "Pragma"         => "no-cache",
            "Expires"        => "Sat, 25 Nov 2000 05:00:00 GMT"
          }
        end

        def body
          ["GIF89a\u0001\u0000\u0001\u0000\x80\xFF\u0000\xFF\xFF\xFF\u0000\u0000\u0000,\u0000\u0000\u0000\u0000\u0001\u0000\u0001\u0000\u0000\u0002\u0002D\u0001\u0000;"]
        end

        def key
          [tracker, id, Time.now.iso8601].join(":")
        end
    end  
  end
end
