import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

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
  icon: Icon(Icons.location_city),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
);

const kCityTextStyle = TextStyle(
  color: Color(0xFF2D2532),
  fontFamily: 'Roboto',
  fontSize: 40.0,
);

const kDateTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 15.0,
  color: Color(0xFFDBDBDB),
);
