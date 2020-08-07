import 'dart:ui';

import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/colour_change_with_time.dart';
import 'package:clima/utilities/weather_info_reusable_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  ColourChangeWithTime colourChangeWithTime = ColourChangeWithTime();
  var decodedData;
  var temperature;
  var condition;
  var cityName;
  var msg;
  var weatherIcon;
  var newTemp;
  int _selectedIndex = 0;
  int day = new DateTime.now().weekday;
  int date = new DateTime.now().day;
  int month = new DateTime.now().month;
  int year = new DateTime.now().year;
  String monthWord;
  String dayWord;
  var getFeelsLike;
  int feelsLike;
  var visibility;
  int pressure;
  var getMaxTemp;
  int maxTemp;
  var windSpeed;
  int humidity;
  double visibilityValue;
  String typedCity;

  var weekday = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday'
  };

  var monthValue = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December'
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(cityName);
    print(DateTime.now().hour);
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        newTemp = 0;
        weatherIcon = 'Error';
        msg = 'Unable to get weather data';
        cityName = '';
        feelsLike = 0;
        visibilityValue = 0;
        pressure = 0;
        maxTemp = 0;
        windSpeed = 0;
        humidity = 0;

        //TODO: initialize all variables with -.- values
        //TODO: update the github readme.md
        return;
      }
      temperature = (weatherData['main']['temp']);
      newTemp = (temperature).toInt();
      print('temp$newTemp');
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      monthWord = monthValue[month];
      dayWord = weekday[day];
      getFeelsLike = weatherData['main']['feels_like'];
      feelsLike = getFeelsLike.toInt();
      print('feels like$feelsLike');
      year = year;
      print(year);
      visibility = weatherData['visibility'];
      print(visibility);
      visibilityValue = visibility / 1000;
      print(visibilityValue);
      pressure = weatherData['main']['pressure'];
      getMaxTemp = weatherData['main']['temp_max'];
      print('getmaxtemp$getMaxTemp');
      maxTemp = getMaxTemp.toInt();
      print(maxTemp);
      windSpeed = weatherData['wind']['speed'];
      humidity = weatherData['main']['humidity'];

      msg = weatherData['weather'][0]['main'];

      weatherIcon = weatherModel.getWeatherIcon(condition);
    });
  }

  Future cityScreen() async {
    var typedCityName = await Navigator.push(
      context,
      CupertinoPageRoute(
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
      backgroundColor: colourChangeWithTime.getContainerColor(),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            selectionWidthStyle: BoxWidthStyle.tight,
                            onChanged: (value) {
                              typedCity = value;
                            },
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),
                            decoration: kTextFieldInputDecoraion,
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        FlatButton(
                          color: colourChangeWithTime.getButtonColor(),
                          padding: EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          onPressed: () async {
                            if (typedCity != null) {
                              var cityWeather =
                                  await weatherModel.getCityWeather(typedCity);
                              updateUI(cityWeather);
                            }
                            FocusScope.of(context).unfocus();
                            new TextEditingController().clear();
                          },
                          child: Text(
                            'Search',
                            style: kButtonTextStyle,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      '$cityName',
                      style: kCityTextStyle,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      '$dayWord $date $monthWord $year',
                      style: kDateTextStyle,
                    )
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  child: Center(
                    child: weatherModel.getWeatherIcon(condition),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$newTemp',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '°',
                      style: TextStyle(
                        fontSize: 40.0,
                        color: colourChangeWithTime.getTempColor(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  '$msg',
                  style: kWeatherDescriptionTextStyle,
                ),
                SizedBox(
                  height: 60.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WeatherInfo(
                      topText: '$feelsLike°',
                      bottomText: 'Feels Like',
                    ),
                    WeatherInfo(
                      topText: '$visibilityValue km',
                      bottomText: 'Visibility',
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WeatherInfo(
                      topText: '$pressure hPa',
                      bottomText: 'Pressure',
                    ),
                    WeatherInfo(
                      topText: '$maxTemp°',
                      bottomText: 'Max Temp',
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WeatherInfo(
                      topText: '$windSpeed km/hr',
                      bottomText: 'Wind',
                    ),
                    WeatherInfo(
                      topText: '$humidity%',
                      bottomText: 'Humidity',
                    ),
                  ],
                )
              ],
            ),
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
