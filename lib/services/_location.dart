// import 'package:geolocator/geolocator.dart';

import 'package:location/location.dart';

class LocationCoordinates {
  double _latitude;
  double _longitude;

  Future<void> getCurrentLocation() async {
    try {
      Location location = Location();
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData locationData;

      _serviceEnabled = await location.serviceEnabled();

      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
      }
      if (!_serviceEnabled) {
        print('denied once');
      }
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      locationData = await location.getLocation();
      print(locationData);
      _latitude = locationData.latitude;
      _longitude = locationData.longitude;
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
