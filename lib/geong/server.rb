require 'geong/geocoder'
require 'geong/server/configuration'
require 'logger'
require 'optparse'

module Geong
  class Server
    @@default_configuration = Configuration.new
    
    def self.start(argv)
      params = ARGV.getopts('','daemon', 'config:')
      
      config_filepath = params["config"] ? File.expand_path(params["config"]) : null
      
      if config_filepath
        @@default_configuration.logger.info "Load config file. #{config_filepath}"
        load config_filepath
      end

      if params["daemon"]
        Process.daemon
      end

      new(@@default_configuration).serve
    end
    
    def self.configure(&block)
      @@default_configuration.configure(&block)
    end

    def initialize(configuration)
      @configuration = configuration
      @logger = configuration.logger
      @server = configuration.get_server
    end
    
    def serve
      @logger.info "Starting the geong server..."
      @server.serve()
    end
  end
end
