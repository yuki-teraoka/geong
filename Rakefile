require "bundler/gem_tasks"
require 'tempfile'
require 'shellwords'

namespace :geong do
  task :generate_thrift do
    output_dir = File.expand_path('../generated/geong/geocoder/', __FILE__)
    thrift_file = File.expand_path('../thrift/geocoder.thrift', __FILE__)
    command = "thrift --gen rb -out #{Shellwords.escape(output_dir)} #{Shellwords.escape(thrift_file)}"
    $stderr.puts(command)
    unless system(command)
      abort "thrift command error!"
    end
    Dir.glob(output_dir + '/*.rb').each do |file|
      file_body = nil
      File.open(file, 'r') do |in_f|
        file_body = in_f.read
      end
      File.open(file, 'w') do |out_f|
        out_f << file_body.gsub("require 'geocoder_", "require 'geong/geocoder/geocoder_")
      end
    end
  end
end