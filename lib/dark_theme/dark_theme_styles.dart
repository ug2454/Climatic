import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      // appBarTheme: isDarkTheme
      //     ? AppBarTheme(brightness: Brightness.dark)
      //     : AppBarTheme(brightness: Brightness.light),
      // primarySwatch: Colors.red,
      // primaryColorBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
      // primaryColor: isDarkTheme ? Colors.white : Colors.black,
      backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
      highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      // textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
      cardColor: isDarkTheme ? Colors.white : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      primaryIconTheme: isDarkTheme
          ? IconThemeData(color: Colors.white)
          : IconThemeData(color: Colors.white),
      textTheme: isDarkTheme
          ? TextTheme(
              bodyText2: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            )
          : TextTheme(
              bodyText2: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),

      // subtitle2: isDarkTheme
      //     ? TextStyle(color: Colors.white)
      //     : TextStyle(color: Colors.black),
      // subtitle1: isDarkTheme
      //     ? TextStyle(color: Colors.white)
      //     : TextStyle(color: Colors.black),
      // headline1: isDarkTheme
      //     ? TextStyle(color: Colors.white)
      //     : TextStyle(color: Colors.black),
      // headline2: isDarkTheme
      //     ? TextStyle(color: Colors.white)
      //     : TextStyle(color: Colors.black),
      // headline3: isDarkTheme
      //     ? TextStyle(color: Colors.white)
      //     : TextStyle(color: Colors.black),
      // headline4: isDarkTheme
      //     ? TextStyle(color: Colors.white)
      //     : TextStyle(color: Colors.black),
      // headline5: isDarkTheme
      //     ? TextStyle(color: Colors.white)
      //     : TextStyle(color: Colors.black),
      // headline6: isDarkTheme
      //     ? TextStyle(color: Colors.black)
      //     : TextStyle(color: Colors.white),
    );
  }
}
