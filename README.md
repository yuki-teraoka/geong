# Geong

Thrift based Geocoding RPC. using the ruby [Geocoder](https://github.com/alexreisner/geocoder "Geocoder") library.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'geong'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install geong

## Usage

### Run Server

    $ geong_server

### Ruby Client

    require "geong"
    client = Geong::Client.new(host: "127.0.0.1")
    client.open
    
    client.coordinates "toko-tower"
     => <Geong::Geocoder::Location latitude:35.6585805, longitude:139.7454329>
    
    client.address("133.11.0.1")
     => "Tokyo, 13 , Japan"

## Configure 

You can give the configuration script by using the -c option.

    $ geong_server -p 19090 -c config.rb

### Thrift Configuration

If you want to change the server settings, please use the Geong::Server.configure block in configuration script.
Configuration DSL supported following methods.

   * logger(default: Logger.new(STDERR)) This option is available only if the default server.
   * port(default: 9090) This option is available only if the default transport.
   * num_threads(default: 20) This option is available only if the default transport.
   * transport(default:  Thrift::ServerSocket)
   * transport_factory(default: Thrift::FramedTransportFactory)
   * protocol_factory(default: nil)
   * server(default: Thrift::NonblockingServer)
   * processor(readOnly) create geong processor

### Example. Using ThinHTTPServer 

    # server(config.rb)
    require "thrift/server/thin_http_server"
    
    Geong::Server.configure do
      server Thrift::ThinHTTPServer.new(processor, {port: 8080})
    end


    # client
    require "geong"
    options = {transport: Thrift::HTTPClientTransport.new("http://127.0.0.1:8080")}
    
    client = Geong::Client.new(options)
    client.open
    
    client.coordinates("TokyoTower")
    

### Geocoder Configuration

you can customize the Geocoder in the config file.
use Geocoder.configure method.

    # config.rb
    Geocoder.configure(
    
      # geocoding service (see below for supported options):
      :lookup => :yandex,
    
      # IP address geocoding service (see below for supported options):
      :ip_lookup => :maxmind,
    
      # to use an API key:
      :api_key => "...",
    
      # geocoding service request timeout, in seconds (default 3):
      :timeout => 5,
    
      # set default units to kilometers:
      :units => :km,
    
      # caching (see below for details):
      :cache => Redis.new,
      :cache_prefix => "..."
    
    )

If have you using Redis, if you want to have a expiration in the cache, please set as follows.
Geong::Cache.redis has been added two options that default_ttl_seconds and default_ttl_miliseconds.
Other options are the same as Redis.new.

    # config.rb
    Geocoder.configure(
      cache: Geong::Cache.redis(default_ttl_seconds: 100)
    )


## Other Languages

Thrift file is located in the following path.
Please create a binding from below if you want to use other languages.

    thrift/geocoder.thrift

## Contributing

1. Fork it ( https://github.com/[my-github-username]/geong/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
