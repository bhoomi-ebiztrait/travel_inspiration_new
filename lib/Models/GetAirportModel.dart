import 'dart:convert';

class GetAirportlModel {
  GetAirportlModel({
    this.name,
    this.place_id,
    this.geometry

  });

  String name;
  String place_id;
  Geometry geometry;


  GetAirportlModel.fromJson(Map map) {
    name = map["name"].toString();
    place_id = map["place_id"].toString();
    geometry = map['geometry'] != null
        ? new Geometry.fromJson(map['geometry'])
        : null;
  }
}
  class Geometry {
    Location location;


    Geometry({this.location,});

    Geometry.fromJson(Map map) {
      location = map['location'] != null
          ? new Location.fromJson(map['location'])
          : null;
    }

  }
  class Location {
  double lat;
  double lng;

  Location({this.lat, this.lng});


  Location.fromJson(Map map) {
    lat = map["lat"];
    lng = map["lng"];
  }





  }



