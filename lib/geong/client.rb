require 'thrift'

module Geong
  class Client
    DEFAULT_HOST = '127.0.0.1'
    DEFAULT_PORT = 9090

    attr_reader :transport, :protocol
    def initialize(options = {})
      @transport = options[:transport] || self.class.default_transport(options)
      @protocol =  options[:protocol ] || self.class.default_protocol(@transport, options)
      @client = Geong::Geocoder::GeocoderService::Client.new(@protocol)
    end
    
    def self.default_transport(options)
      Thrift::FramedTransport.new(Thrift::Socket.new(options[:host] || DEFAULT_HOST, options[:port] || DEFAULT_PORT))
    end
    
    def self.default_protocol(transport, options)
      Thrift::BinaryProtocol.new(transport)
    end
    
    def open
      @transport.open
      self
    end
    
    def open?
      @transport.open?
    end
    
    def close
      @transport.close
      self
    end
    
    def closed?
      @transport.closed?
    end
    
    def respond_to_missing?(method, include_private)
      @client.respond_to?(method, include_private)
    end
    
    def method_missing(*args, &block)
      @client.send(*args, &block)
    end
  end
end
