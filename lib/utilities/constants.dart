import 'package:clima/screens/location_screen.dart';
import 'package:clima/utilities/colour_change_with_time.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';

ColourChangeWithTime _colourChangeWithTime = ColourChangeWithTime();
LocationScreen locationScreen = LocationScreen();
WeatherModel weatherModel = WeatherModel();

var kTempTextStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 100.0,
    fontWeight: FontWeight.w200,
    color: _colourChangeWithTime.getTempColor());

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

var kButtonTextStyle = TextStyle(
  fontSize: 20.0,
  color: _colourChangeWithTime.getButtonTextColor(),
  fontFamily: 'Poppins',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

// var kTextFieldInputDecoraion = InputDecoration(
//   hintText: 'Enter a city name',
//   hintStyle: TextStyle(
//     color: Colors.black,
//   ),
//   filled: true,
//   fillColor: Colors.white,
//   icon: GestureDetector(
//     onTap: () async {
//       print('icon clicked');
//       var weatherData = await weatherModel.getLocationWeather();
//       updateUI(weatherData);
//     },
//     child: Icon(
//       Icons.search,
//       size: 40.0,
//       color: Color(0xFFc41a43),
//     ),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderSide: BorderSide(
//       color: Color(0xFFc41a43),
//     ),
//   ),
//   border: OutlineInputBorder(
//     borderRadius: BorderRadius.all(
//       Radius.circular(10.0),
//     ),
//   ),
// );

var kCityTextStyle = TextStyle(
  color: _colourChangeWithTime.getCityTextColor(),
  fontFamily: 'Poppins',
  fontSize: 40.0,
);

const kDateTextStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15.0,
    color: Color(0xFFbdb9b9),
    fontWeight: FontWeight.bold);

const kWeatherDescriptionTextStyle = TextStyle(
    color: Color(0xFFc41a43),
    fontSize: 20.0,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold);
