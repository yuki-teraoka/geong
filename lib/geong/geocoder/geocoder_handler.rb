require 'geocoder'

module Geong
  module Geocoder
    class GeocoderHandler
      def coordinates(address)
        result = ::Geocoder.coordinates(address)
        if result.nil?
          raise NoResultException, "coordinates not found. address: #{address}"
        end
        location = Location.new
        location.latitude = result[0]
        location.longitude = result[1]
        location
      rescue TimeoutError => e
        raise TimeoutException, e.message
      end
      
      def address(query)
        result = ::Geocoder.address(query)
        if result.nil?
          raise NoResultException, "address not found. query: #{query}"
        end
        result
      rescue TimeoutError => e
        raise TimeoutException, e.message
      end
    end
  end
end
