import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';

LocationScreen locationScreen = LocationScreen();
WeatherModel weatherModel = WeatherModel();

var kTempTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 100.0,
  fontWeight: FontWeight.w200,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

var kCityTextStyle = TextStyle(
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

const kAlertBoxDecoration = BoxDecoration(color: Colors.blueAccent, boxShadow: [
  BoxShadow(
    color: Colors.blue,
    offset: Offset(2.0, 1.0),
  )
]);

const kAlertBoxTextStyle = TextStyle(color: Colors.white, fontSize: 17.0);

const kExpansionPanelTextStyle =
    TextStyle(fontSize: 15.0, fontFamily: 'Poppins', color: Colors.black);

const kHealthTextStyle = TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic);

const kTextFieldInputDecoration = InputDecoration(
  hintText: 'Search city name',
  contentPadding: EdgeInsets.all(10.0),
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  filled: true,
  fillColor: Colors.white,
  prefixIcon: Icon(
    Icons.search,
    color: Color(0xFFc41a43),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30.0),
    ),
    borderSide: BorderSide(
      color: Color(0xFFc41a43),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30.0),
    ),
    borderSide: BorderSide(
      color: Color(0xFFc41a43),
    ),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFc41a43),
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(30.0),
    ),
  ),
);

const kTextStyleColorBlack = TextStyle(color: Colors.black);

const kBlackColor = Colors.black;

const kWhiteColor = Colors.white;

const kTextStyleColorWhite = TextStyle(color: Colors.white);
