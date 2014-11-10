
namespace rb Geong.Geocoder
namespace java geong.geocoder
namespace php geong.geocoder
namespace py geong_geocoder
namespace cpp Geong


struct Location
{
  1:double latitude,
  2:double longitude
}

exception NoResultException
{
  1:string message
}

exception TimeoutException
{
  1:string message
}

service GeocoderService 
{
  Location coordinates(1:string address) throws(1:NoResultException error, 2:TimeoutException error2),
  string address(1:string query) throws(1:NoResultException error, 2:TimeoutException error2),
}
