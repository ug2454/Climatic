import 'dart:ui';

import 'package:clima/services/address_search.dart';
import 'package:clima/services/place_service.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/colour_change_with_time.dart';
import 'package:clima/utilities/weather_info_reusable_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

const googleAPIKey = 'AIzaSyBVu6kY2gzNmzfXJP7noby7wDjuPiQg-ik';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather, this.hourlyWeather});
  final locationWeather;
  final hourlyWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  ColourChangeWithTime colourChangeWithTime = ColourChangeWithTime();
  final _controller = TextEditingController();

  var decodedData;
  var temperature;
  var condition;
  var cityName;
  var msg;
  var weatherIcon;
  var newTemp;
  int _selectedIndex = 0;
  int day = new DateTime.now().weekday;
  int date = new DateTime.now().day;
  int month = new DateTime.now().month;
  int year = new DateTime.now().year;
  String monthWord;
  String dayWord;
  var getFeelsLike;
  int feelsLike;
  var visibility;
  int pressure;
  var getMaxTemp;
  int maxTemp;
  var windSpeed;
  int humidity;
  double visibilityValue;
  String typedCity;
  List<String> items = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  List hourlyDataList;
  int hourlySize;
  List tempList = [];
  String weatherIconUrl = 'http://openweathermap.org/img/wn/';
  List<String> iconList = [];
  List<String> dateList = [];

  var weekday = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday'
  };

  var monthValue = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December'
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateUI(widget.locationWeather);
    updateHourlyData(widget.hourlyWeather);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateHourlyData(dynamic hourlyData) {
    hourlyDataList = hourlyData['list'];
    hourlySize = hourlyDataList.length;

    tempList.add(hourlyData['list'][0]['main']['temp']);
    for (int i = 0; i < hourlySize; i++) {
      tempList.add(hourlyData['list'][i]['main']['temp']);
      iconList.add(hourlyData['list'][i]['weather'][0]['icon']);
      String date = hourlyData['list'][i]['dt_txt'];
      date = date.substring(11, 16);
      dateList.add(date);
    }
  }

  Future<void> _data() async {
    setState(() {
      refreshData();
    });
  }

  void refreshData() async {
    setState(() {
      updateUI(widget.locationWeather);
      _controller.clear();
    });
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        newTemp = 0;
        weatherIcon = 'Error';
        msg = 'Unable to get weather data';
        cityName = '';
        feelsLike = 0;
        visibilityValue = 0;
        pressure = 0;
        maxTemp = 0;
        windSpeed = 0;
        humidity = 0;

        return;
      }
      temperature = (weatherData['main']['temp']);
      newTemp = (temperature).toInt();

      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      monthWord = monthValue[month];
      dayWord = weekday[day];
      getFeelsLike = weatherData['main']['feels_like'];
      feelsLike = getFeelsLike.toInt();

      year = year;

      visibility = weatherData['visibility'];

      visibilityValue = visibility / 1000;

      pressure = weatherData['main']['pressure'];
      getMaxTemp = weatherData['main']['temp_max'];

      maxTemp = getMaxTemp.toInt();

      windSpeed = weatherData['wind']['speed'];
      humidity = weatherData['main']['humidity'];

      msg = weatherData['weather'][0]['main'];

      weatherIcon = weatherModel.getWeatherIcon(condition);
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure'),
            content: Text('Do you want to exit the app?'),
            actions: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: AlertBoxWidget(
                  text: 'No',
                ),
              ),
              GestureDetector(
                onTap: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: AlertBoxWidget(
                  text: 'Yes',
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  void searchCity() async {
    var cityWeather = await weatherModel.getCityWeather(typedCity);
    var cityHourlyWeather = await weatherModel.getCityHourlyWeather(typedCity);
    updateUI(cityWeather);
    tempList = [];
    iconList = [];
    dateList = [];
    updateHourlyData(cityHourlyWeather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colourChangeWithTime.getContainerColor(),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: RefreshIndicator(
              onRefresh: _data,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: TextField(
                                  // selectionWidthStyle: BoxWidthStyle.tight,
                                  controller: _controller,

                                  readOnly: true,
                                  onTap: () async {
                                    // typedCity = value;
                                    final sessionToken = Uuid().v4();
                                    final Suggestion result = await showSearch(
                                        context: context,
                                        delegate: AddressSearch(sessionToken));
                                    print(result);

                                    setState(() {
                                      try {
                                        if (result.description != null) {
                                          _controller.text = result.description;
                                          typedCity = _controller.text;
                                          searchCity();
                                        } else {
                                          _controller.text = '';
                                          typedCity = _controller.text;
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    });
                                  },
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                  decoration: InputDecoration(
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
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: Color(0xFFc41a43),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  //current weather location
                                  onTap: () async {
                                    var cityHourlyWeather =
                                        await weatherModel.getHourlyWeather();
                                    tempList = [];
                                    iconList = [];
                                    dateList = [];
                                    updateHourlyData(cityHourlyWeather);
                                    var weatherData =
                                        await weatherModel.getLocationWeather();
                                    updateUI(weatherData);
                                    _controller.clear();
                                  },
                                  child: Icon(
                                    Icons.place,
                                    size: 40.0,
                                    color: Color(0xFFc41a43),
                                  ),
                                ),
                              ),
                              // FlatButton(
                              //   color: colourChangeWithTime.getButtonColor(),
                              //   padding: EdgeInsets.all(9.0),
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(30.0),
                              //   ),
                              //   onPressed: () async {
                              //     if (typedCity != null) {
                              //       var cityWeather = await weatherModel
                              //           .getCityWeather(typedCity);
                              //       var cityHourlyWeather = await weatherModel
                              //           .getCityHourlyWeather(typedCity);
                              //       updateUI(cityWeather);
                              //       tempList = [];
                              //       iconList = [];
                              //       dateList = [];
                              //       updateHourlyData(cityHourlyWeather);
                              //     }
                              //     FocusScope.of(context).unfocus();
                              //     new TextEditingController().clear();
                              //   },
                              //   child: Text(
                              //     'Search',
                              //     style: kButtonTextStyle,
                              //   ),
                              // )
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            '$cityName',
                            style: kCityTextStyle,
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '$dayWord $date $monthWord $year',
                            style: kDateTextStyle,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        child: Center(
                          child: weatherModel.getWeatherIcon(condition),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$newTemp',
                            style: kTempTextStyle,
                          ),
                          Text(
                            '°',
                            style: TextStyle(
                              fontSize: 40.0,
                              color: colourChangeWithTime.getTempColor(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        '$msg',
                        style: kWeatherDescriptionTextStyle,
                      ),
                      SizedBox(
                        height: 60.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WeatherInfo(
                            topText: '$feelsLike°',
                            bottomText: 'Feels Like',
                          ),
                          WeatherInfo(
                            topText: '$visibilityValue km',
                            bottomText: 'Visibility',
                          ),
                        ],
                      ),
                      SizedBox(height: 50.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WeatherInfo(
                            topText: '$pressure hPa',
                            bottomText: 'Pressure',
                          ),
                          WeatherInfo(
                            topText: '$maxTemp°',
                            bottomText: 'Max Temp',
                          ),
                        ],
                      ),
                      SizedBox(height: 50.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WeatherInfo(
                            topText: '$windSpeed km/hr',
                            bottomText: 'Wind',
                          ),
                          WeatherInfo(
                            topText: '$humidity%',
                            bottomText: 'Humidity',
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            )),
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 100.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 9,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 90.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    tempList[index].toInt().toString() + '°',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    width: 50.0,
                                    child: Image(
                                      image: NetworkImage(
                                          '$weatherIconUrl${iconList[index]}@4x.png',
                                          scale: 2),
                                    ),
                                  ),
                                  Text(
                                    dateList[index],
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AlertBoxWidget extends StatelessWidget {
  const AlertBoxWidget({
    Key key,
    @required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kAlertBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
        child: Text(
          text,
          style: kAlertBoxTextStyle,
        ),
      ),
    );
  }
}
