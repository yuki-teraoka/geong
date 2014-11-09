require 'geong/geocoder'
require 'logger'
require 'optparse'

module Geong
  class Server
    class Configuration
      DEFAULT_PORT = 9090
      DEFAULT_NUM_THREADS = 20
      DEFAULT_LOGGER = Logger.new(STDERR)
      DEFAULT_LOGGER.level = Logger::DEBUG

      attr_writer :logger, :port, :num_threads, :transport, :transport_factory, :protocol_factory, :server
      
      def configure(&block)
        self.instance_exec(self, &block)
        self
      end
      
      def processor
        handler = Geocoder::GeocoderHandler.new()
        Geocoder::GeocoderService::Processor.new(handler)
      end
      
      def port(port = nil)
        self.port = port if port
        get_port
      end
      
      def get_port
        @port ||= DEFAULT_PORT
      end
      
      def num_threads(num_threads = nil)
        self.num_threads = num_threads if num_threads
        get_num_threads
      end
      
      def get_num_threads
        @num_threads ||= DEFAULT_NUM_THREADS
      end
      
      def logger(logger = nil)
        self.logger = logger if logger
        get_logger
      end
      
      def get_logger
        @logger ||= DEFAULT_LOGGER
      end
      
      def transport(transport = nil)
        self.transport = transport if transport
        get_transport
      end
      
      def get_transport
        @transport ||= Thrift::ServerSocket.new(port)
      end
      
      def transport_factory(transport_factory = nil)
        self.transport_factory = transport_factory if transport_factory
        get_transport_factory ||= Thrift::FramedTransportFactory.new
      end
      
      def get_transport_factory
        @transport_factory
      end
      
      def protocol_factory(protocol_factory = nil)
        self.protocol_factory = protocol_factory if protocol_factory
        get_protocol_factory
      end
      
      def get_protocol_factory
        @protocol_factory
      end
      
      def server(server = nil)
        self.server =server if server
        get_server
      end
      
      def get_server
        return @server if @server
        @server ||= Thrift::NonblockingServer.new(processor, transport, transport_factory, protocol_factory, num_threads, logger)
      end
    end
  end
end
