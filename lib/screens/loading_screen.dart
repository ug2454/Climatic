import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/_location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = "a9f0de43f7ae80b8312ceb33a386b6b3";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  double latitude;
  double longitude;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getLocationData();

    print('in init state');
  }

  Future<void> getLocationData() async {
    LocationCoordinates location = LocationCoordinates();
    await location.getCurrentLocation();
    latitude = location.getLatitude();
    longitude = location.getLongitude();
    NetworkHelper networkHelper = NetworkHelper(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey");
    var weatherData = await networkHelper.getData();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 50.0,
          controller: AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
