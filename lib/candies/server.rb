module Candies
  class Server
    def call(env)
      req = Rack::Request.new(env)
      id = req.params.delete("id")
      Candies.redis.set([id, Time.now.iso8601].join(":"), req.params.to_json) if !id.nil?
      [200, headers, [image]]
    end

    private
      def headers
        {
          "Content-Type"   => "image/gif", 
          "Content-Length" => "35", 
          "Cache-Control"  => "no-store, no-cache, must-revalidate, private",
          "Pragma"         => "no-cache",
          "Expires"        => "Sat, 25 Nov 2000 05:00:00 GMT"
        }
      end

      def image
        "GIF89a\u0001\u0000\u0001\u0000\x80\xFF\u0000\xFF\xFF\xFF\u0000\u0000\u0000,\u0000\u0000\u0000\u0000\u0001\u0000\u0001\u0000\u0000\u0002\u0002D\u0001\u0000;"
      end
  
  end
end
