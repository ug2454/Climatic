import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'dart:math';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  var decodedData;
  double temperature;
  var condition;
  var cityName;
  var msg;
  var weatherIcon;
  int newTemp;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(cityName);
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        newTemp = 0;
        weatherIcon = 'Error';
        msg = 'Unable to get weather data';
        cityName = '';
        return;
      }
      temperature = (weatherData['main']['temp']);
      newTemp = (temperature - 273.15).round();
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];

      msg = weatherModel.getMessage(newTemp);

      weatherIcon = weatherModel.getWeatherIcon(condition);
    });
  }

  Future cityScreen() async {
    var typedCityName = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CityScreen();
        },
      ),
    );
    if (typedCityName != null) {
      var cityWeather = await weatherModel.getCityWeather(typedCityName);
      updateUI(cityWeather);
    }
  }

  Future getCurrentWeather() async {
    var weatherData = await weatherModel.getLocationWeather();
    updateUI(weatherData);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        cityScreen();
      }
      if (_selectedIndex == 0) {
        getCurrentWeather();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me),
            title: Text('Current Location'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            title: Text('Search City'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              Column(
                
                children: [
                  Text(
                    'Sydney',
                    style: kCityTextStyle,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Thursday 15 August 2020',
                    style: kDateTextStyle,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('images/location_background.jpg'),
//           fit: BoxFit.cover,
//           colorFilter: ColorFilter.mode(
//               Colors.white.withOpacity(0.8), BlendMode.dstATop),
//         ),
//       ),
//       constraints: BoxConstraints.expand(),
//       child: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   FlatButton(
//                     onPressed: () async {
//                       var weatherData =
//                           await weatherModel.getLocationWeather();
//                       updateUI(weatherData);
//                     },
//                     child: Icon(
//                       Icons.near_me,
//                       size: 50.0,
//                     ),
//                   ),
//                   FlatButton(
//                     onPressed: () async {
//                       var typedCityName = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) {
//                             return CityScreen();
//                           },
//                         ),
//                       );
//                       if (typedCityName != null) {
//                         var cityWeather =
//                             await weatherModel.getCityWeather(typedCityName);
//                         updateUI(cityWeather);
//                       }
//                     },
//                     child: Icon(
//                       Icons.location_city,
//                       size: 50.0,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 100.0,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 15.0),
//                 child: Row(
//                   children: <Widget>[
//                     Text(
//                       '$newTemp',
//                       style: kTempTextStyle,
//                     ),
//                     Text(
//                       '$weatherIcon',
//                       style: kConditionTextStyle,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 120.0,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(right: 15.0),
//                 child: Text(
//                   '$msg in $cityName!',
//                   textAlign: TextAlign.right,
//                   style: kMessageTextStyle,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
