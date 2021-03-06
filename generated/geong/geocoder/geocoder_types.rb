#
# Autogenerated by Thrift Compiler (0.9.1)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'

module Geong
  module Geocoder
    class Location
      include ::Thrift::Struct, ::Thrift::Struct_Union
      LATITUDE = 1
      LONGITUDE = 2

      FIELDS = {
        LATITUDE => {:type => ::Thrift::Types::DOUBLE, :name => 'latitude'},
        LONGITUDE => {:type => ::Thrift::Types::DOUBLE, :name => 'longitude'}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class NoResultException < ::Thrift::Exception
      include ::Thrift::Struct, ::Thrift::Struct_Union
      def initialize(message=nil)
        super()
        self.message = message
      end

      MESSAGE = 1

      FIELDS = {
        MESSAGE => {:type => ::Thrift::Types::STRING, :name => 'message'}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class TimeoutException < ::Thrift::Exception
      include ::Thrift::Struct, ::Thrift::Struct_Union
      def initialize(message=nil)
        super()
        self.message = message
      end

      MESSAGE = 1

      FIELDS = {
        MESSAGE => {:type => ::Thrift::Types::STRING, :name => 'message'}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

  end
end
