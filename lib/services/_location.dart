import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// import 'package:location/location.dart';

class LocationCoordinates {
  double _latitude;
  double _longitude;

  Future getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      _latitude = position.latitude;
      _longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  double getLatitude() {
    return _latitude;
  }

  double getLongitude() {
    return _longitude;
  }
}
