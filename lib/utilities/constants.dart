import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
    fontFamily: 'Poppins', fontSize: 100.0, fontWeight: FontWeight.w200);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 20.0,
  // fontFamily: 'Spartan MB',
  color: Colors.white,
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldInputDecoraion = InputDecoration(
  hintText: 'Enter a city name',
  hintStyle: TextStyle(
    color: Colors.black,
  ),
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.search,
    size: 40.0,
    color: Color(0xFFc41a43),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFc41a43),
    ),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
);

const kCityTextStyle = TextStyle(
  color: Color(0xFF2D2532),
  fontFamily: 'Poppins',
  fontSize: 40.0,
);

const kDateTextStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15.0,
    color: Color(0xFFbdb9b9),
    fontWeight: FontWeight.bold);

const kBottomNavigationBarItemColor = Color(0xFFc41a43);

const kBottomNavigationBarTextStyle = TextStyle(
  fontFamily: 'Poppins',
);

const kWeatherDescriptionTextStyle = TextStyle(
    color: Color(0xFFc41a43),
    fontSize: 20.0,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold);
