import 'package:clima/dark_theme/dark_theme_provider.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen();
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkModeEnabled = false;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Settings',
          style: kCityTextStyle.copyWith(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return LoadingScreen();
              },
            ));
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SwitchListTile(
            value: themeChange.darkTheme,
            activeColor: Color(0xFFc41a43),
            title: Text(
              'Dark Mode',
              style: kCityTextStyle.copyWith(
                  fontSize: 20.0, color: Color(0xFFc41a43)),
            ),
            onChanged: (value) {
              setState(() {
                themeChange.darkTheme = value;
              });
            }),
      ),
    );
  }
}
