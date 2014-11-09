
module Geong
  module Cache
    def self.redis(options = {})
      require "redis"
      redis = Redis.new(options)
      if options[:default_ttl_seconds] or options[:default_ttl_milliseconds]
        redis.singleton_class.prepend RedisDefaultTTL
        redis.default_ttl_seconds = options[:default_ttl_seconds]
        redis.default_ttl_milliseconds = options[:default_ttl_milliseconds]
      end
      redis
    end

    module RedisDefaultTTL
      def default_ttl_seconds=(ttl_seconds)
        @default_ttl_seconds = ttl_seconds
      end
      
      def default_ttl_milliseconds=(ttl_milliseconds)
        @default_ttl_milliseconds = ttl_milliseconds
      end
      
      def []=(key, value)
        set(key, value, {ex: @default_ttl_seconds, px: @default_ttl_milliseconds})
      end
    end
  end
end
