module Candies
  module Server
    class Json < Base
      
      def call(env)
        @request = Rack::Request.new(env)
        [status, headers, body]
      end

      protected
        def headers
          {
            "Content-Type" => "application/json" 
          }
        end

        def key
          "#{[tracker, id].compact.join(":")}*"
        end

        def body
          [Candies.redis.keys(key).inject({}) {|body, k| body[k] = Candies.redis.get(k);body }.to_json]
        end
    end  
  end
end
