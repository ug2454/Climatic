
import 'package:flutter/material.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({this.topText, this.bottomText});
  final String topText;
  final String bottomText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          '$topText',
          style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
        Text(
          '$bottomText',
          style: TextStyle(
            color: Color(0xFF7a7878),
          ),
        ),
      ],
    );
  }
}
