import 'package:clima/services/_location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/colour_change_with_time.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttericon/meteocons_icons.dart';
import 'package:clima/utilities/api.dart';

const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const openWeatherForecastURL =
    'https://api.openweathermap.org/data/2.5/forecast';

const openWeatherDailyForecastURL =
    'http://api.openweathermap.org/data/2.5/forecast/daily';

class WeatherModel {
  static final String openWeatherAPIKey = kOpenWeatherAPIKey;
  ColourChangeWithTime _colourChangeWithTime = ColourChangeWithTime();
  Icon getWeatherIcon(int condition) {
    if (condition < 300) {
      return Icon(
        Meteocons.cloud_flash_alt,
        size: 70.0,
        color: _colourChangeWithTime.getWeatherIconColor(),
      );
    } else if (condition < 400) {
      return Icon(
        Meteocons.drizzle,
        size: 70.0,
        color: _colourChangeWithTime.getWeatherIconColor(),
      );
    } else if (condition < 600) {
      return Icon(
        Meteocons.windy_rain,
        size: 70.0,
        color: _colourChangeWithTime.getWeatherIconColor(),
      );
    } else if (condition < 700) {
      return Icon(
        Meteocons.snow_alt,
        size: 70.0,
        color: _colourChangeWithTime.getWeatherIconColor(),
      );
    } else if (condition < 800) {
      return Icon(
        Meteocons.fog_cloud,
        size: 70.0,
        color: _colourChangeWithTime.getWeatherIconColor(),
      );
    } else if (condition == 800) {
      return Icon(
        Meteocons.sun,
        size: 70.0,
        color: _colourChangeWithTime.getWeatherIconColor(),
      );
    } else if (condition <= 804) {
      return Icon(
        Meteocons.clouds,
        size: 70.0,
        color: _colourChangeWithTime.getWeatherIconColor(),
      );
    } else {
      return Icon(
        Meteocons.cloud_sun_inv,
        size: 70.0,
        color: _colourChangeWithTime.getWeatherIconColor(),
      );
    }
  }

  Future<dynamic> getCityWeather(String cityName) async {
    print(openWeatherAPIKey);
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$openWeatherAPIKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    print(openWeatherAPIKey);
    LocationCoordinates location = LocationCoordinates();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.getLatitude()}&lon=${location.getLongitude()}&appid=$openWeatherAPIKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getHourlyWeather() async {
    LocationCoordinates location = LocationCoordinates();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherForecastURL?lat=${location.getLatitude()}&lon=${location.getLongitude()}&appid=$openWeatherAPIKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCityHourlyWeather(String cityName) async {
    LocationCoordinates location = LocationCoordinates();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherForecastURL?q=$cityName&appid=$openWeatherAPIKey&units=metric');
    var weatherData = networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getDailyWeather() async {
    LocationCoordinates location = LocationCoordinates();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherDailyForecastURL?lat=${location.getLatitude()}&lon=${location.getLongitude()}&cnt=7&appid=$kOpenWeatherAPIKey&units=metric');
    var weatherData = networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getDailyWeatherCity(String cityName) async {
    LocationCoordinates location = LocationCoordinates();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherDailyForecastURL?q=$cityName&cnt=7&appid=$kOpenWeatherAPIKey&units=metric');
    var weatherData = networkHelper.getData();
    return weatherData;
  }
}
