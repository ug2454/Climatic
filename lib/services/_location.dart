import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;

// import 'package:location/location.dart';

class LocationCoordinates {
  double _latitude;
  double _longitude;

  Future getCurrentLocation() async {
    try {
      final loc.Location location = loc.Location();
      location.requestService();
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
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
