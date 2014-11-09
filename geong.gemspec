# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geong/version'

Gem::Specification.new do |spec|
  spec.name          = "geong"
  spec.version       = Geong::VERSION
  spec.authors       = ["yuki teraoka"]
  spec.email         = ["teraoka.yuki@synergy101.jp"]
  spec.summary       = %q{Thrift based Geocoding RPC.}
  spec.description   = %q{Thrift based Geocoding RPC. using the ruby Geocoder library.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "generated"]

  spec.add_runtime_dependency "geocoder"
  spec.add_runtime_dependency "thrift"
  spec.add_development_dependency "redis"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
