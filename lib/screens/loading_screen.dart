import 'package:clima/screens/expansion_panel_screen.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getLocationData();

    print('in init state');
  }

  Future getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();
    var hourlyData = await weatherModel.getHourlyWeather();
    var dailyData = weatherModel.getDailyWeather();
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return LocationScreen(
          locationWeather: weatherData,
          hourlyWeather: hourlyData,
          dailyWeather: dailyData,
        );
      },
    ));
    // Navigator.push(context, MaterialPageRoute(
    //   builder: (context) {
    //     return ExpansionpanelScreen();
    //   },
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpgradeAlert(
        child: Center(
          child: SpinKitCubeGrid(
            color: Color(0xFFc41a43),
            size: 100.0,
            controller: AnimationController(
              vsync: this,
              duration: const Duration(milliseconds: 1200),
            ),
          ),
        ),
      ),
    );
  }
}
