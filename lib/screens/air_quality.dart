import 'package:clima/screens/loading_screen.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

class AiqQualityScreen extends StatefulWidget {
  @override
  _AiqQualityScreenState createState() => _AiqQualityScreenState();
}

class _AiqQualityScreenState extends State<AiqQualityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Climatic',
          style: kCityTextStyle.copyWith(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.popUntil(context, ModalRoute.withName(LocationScreen.id));
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Center(child: Text('Air Quality')),
            ],
          ),
        ),
      ),
    );
  }
}
