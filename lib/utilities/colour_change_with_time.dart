import 'package:flutter/material.dart';

class ColourChangeWithTime {
  var hour = DateTime.now().hour;

  Color getContainerColor() {
    if (hour > 18 && hour <= 23 || hour >= 0 && hour < 5) {
      return Colors.black;
    }
    return Colors.white;
  }

  Color getCityTextColor() {
    if (hour > 18 && hour <= 23 || hour >= 0 && hour < 5) {
      return Colors.white;
    }
    return Color(0xFF2D2532);
  }

  Color getWeatherIconColor() {
    if (hour > 18 && hour <= 23 || hour >= 0 && hour < 5) {
      return Colors.white;
    }
    return Color(0xFF2D2532);
  }

  Color getTempColor() {
    if (hour > 18 && hour <= 23 || hour >= 0 && hour < 5) {
      return Colors.white;
    }
    return Colors.black;
  }

  Color getButtonColor() {
    if (hour > 18 && hour <= 23 || hour >= 0 && hour < 5) {
      return Colors.white;
    }
    return Color(0xFFc41a43);
  }

  Color getButtonTextColor() {
    if (hour > 18 && hour <= 23 || hour >= 0 && hour < 5) {
      return Color(0xFFc41a43);
    }
    return Colors.white;
  }
}
