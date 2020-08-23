import 'dart:ui';

import 'package:clima/screens/expansion_panel_screen.dart';
import 'package:clima/services/address_search.dart';
import 'package:clima/services/place_service.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/colour_change_with_time.dart';
import 'package:clima/utilities/weather_info_reusable_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:uuid/uuid.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

const googleAPIKey = 'AIzaSyBVu6kY2gzNmzfXJP7noby7wDjuPiQg-ik';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather, this.hourlyWeather, this.dailyWeather});
  final locationWeather;
  final hourlyWeather;
  final dailyWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with TickerProviderStateMixin {
  WeatherModel weatherModel = WeatherModel();
  ColourChangeWithTime colourChangeWithTime = ColourChangeWithTime();
  final _controller = TextEditingController();
  bool showSpinner = false;
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
  String newTypedCity;
  List<String> items = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  List hourlyDataList;
  int hourlySize;
  List tempList = [];
  String weatherIconUrl = 'http://openweathermap.org/img/wn/';
  List<String> iconList = [];
  List<String> dateList = [];
  var dailyweather;
  List<Item> _data1;
  List dailyMinTempList = [];
  List dailyMaxTempList = [];

  List<String> dailyIconList = [];
  List<int> dailyEpochDateList = [];
  List dailyDataList;
  int dailySize;
  List<int> dailyWeekDayDateList = [];
  List<int> dailyDayDateList = [];
  List<int> dailyMonthDateList = [];
  List dailyHumidity = [];
  List dailyDescription = [];
  List dailyPressure = [];
  List dailyFeelslike = [];

  var weekday = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday'
  };

  var weekday1 = {
    1: 'Mon',
    2: 'Tue',
    3: 'Wed',
    4: 'Thu',
    5: 'Fri',
    6: 'Sat',
    7: 'Sun'
  };
  var monthValue = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec'
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateUI(widget.locationWeather);
    updateHourlyData(widget.hourlyWeather);
    updateDailyData(widget.dailyWeather);

    _data1 = generateItems(7);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateDailyData(dynamic dailyData) {
    dailyDataList = dailyData['list'];
    dailySize = dailyDataList.length;
    for (int i = 0; i < dailySize; i++) {
      dailyMinTempList.add(dailyData['list'][i]['temp']['min']);

      dailyMaxTempList.add(dailyData['list'][i]['temp']['max']);

      dailyIconList.add(dailyData['list'][i]['weather'][0]['icon']);
      dailyEpochDateList.add(dailyData['list'][i]['dt']);
      dailyDayDateList.add(
          DateTime.fromMillisecondsSinceEpoch(dailyEpochDateList[i] * 1000)
              .day
              .toInt());
      dailyWeekDayDateList.add(
          DateTime.fromMillisecondsSinceEpoch(dailyEpochDateList[i] * 1000)
              .weekday
              .toInt());
      dailyMonthDateList.add(
          DateTime.fromMillisecondsSinceEpoch(dailyEpochDateList[i] * 1000)
              .month
              .toInt());
      dailyHumidity.add(dailyData['list'][i]['humidity']);
      dailyDescription.add(dailyData['list'][i]['weather'][0]['main']);
      dailyPressure.add(dailyData['list'][i]['pressure']);
      dailyFeelslike.add(dailyData['list'][i]['feels_like']['day']);
    }
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
      tempList = [];
      iconList = [];
      dateList = [];
      updateHourlyData(widget.hourlyWeather);

      dailyIconList = [];
      dailyDescription = [];
      dailyFeelslike = [];
      dailyHumidity = [];
      dailyMaxTempList = [];
      dailyMinTempList = [];
      dailyDayDateList = [];
      dailyMonthDateList = [];
      dailyPressure = [];
      dailyWeekDayDateList = [];

      updateDailyData(widget.dailyWeather);
      _data1 = generateItems(7);
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

      showSpinner = false;
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
    var cityDailyWeather = await weatherModel.getDailyWeatherCity(typedCity);
    updateUI(cityWeather);
    tempList = [];
    iconList = [];
    dateList = [];
    updateHourlyData(cityHourlyWeather);

    dailyIconList = [];
    dailyDescription = [];
    dailyFeelslike = [];
    dailyHumidity = [];
    dailyMaxTempList = [];
    dailyMinTempList = [];
    dailyDayDateList = [];
    dailyMonthDateList = [];
    dailyPressure = [];
    dailyWeekDayDateList = [];

    updateDailyData(cityDailyWeather);
    _data1 = generateItems(7);
    setState(() {
      showSpinner = false;
    });
  }

  List<Item> generateItems(int numberOfItems) {
    return List.generate(numberOfItems, (int index) {
      return Item(
        headerValue: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    child: Image(
                      image: NetworkImage(
                          '$weatherIconUrl${dailyIconList[index]}@4x.png',
                          scale: 2),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    '${weekday1[dailyWeekDayDateList[index]]}, ${dailyDayDateList[index]} ${monthValue[dailyMonthDateList[index]]}',
                    style: kExpansionPanelTextStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${dailyMinTempList[index].toInt()}°',
                    style: kExpansionPanelTextStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${dailyMaxTempList[index].toInt()}°',
                    style: kExpansionPanelTextStyle,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
        expandedValue: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Humidity',
                    style: kExpansionPanelTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 38.0,
                  ),
                  Text(
                    '${dailyHumidity[index]}%',
                    style: kExpansionPanelTextStyle,
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: kExpansionPanelTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    '${dailyDescription[index]}',
                    style: kExpansionPanelTextStyle,
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Pressure',
                    style: kExpansionPanelTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 40.0,
                  ),
                  Text(
                    '${dailyPressure[index]} hPa',
                    style: kExpansionPanelTextStyle,
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Feels Like',
                    style: kExpansionPanelTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 35.0,
                  ),
                  Text(
                    '${dailyFeelslike[index].toInt()}°',
                    style: kExpansionPanelTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colourChangeWithTime.getContainerColor(),
      body: ModalProgressHUD(
        progressIndicator: SpinKitCubeGrid(
          color: colourChangeWithTime.getCityTextColor(),
          size: 100.0,
          controller: AnimationController(
            duration: const Duration(milliseconds: 1200),
            vsync: this,
          ),
        ),
        inAsyncCall: showSpinner,
        child: WillPopScope(
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
                                      // TODO: filter the name till first comma to avoid error
                                      final sessionToken = Uuid().v4();
                                      final Suggestion result =
                                          await showSearch(
                                              context: context,
                                              delegate:
                                                  AddressSearch(sessionToken));

                                      setState(() {
                                        try {
                                          if (result.description != null) {
                                            print('result description' +
                                                result.description);
                                            setState(() {
                                              showSpinner = true;
                                            });
                                            _controller.text =
                                                result.description;

                                            if (_controller.text
                                                .contains(',')) {
                                              typedCity = _controller.text
                                                  .substring(
                                                      0,
                                                      _controller.text
                                                          .indexOf(','));
                                            } else if (_controller.text
                                                .contains('-')) {
                                              typedCity = _controller.text
                                                  .substring(
                                                      0,
                                                      _controller.text
                                                          .indexOf('-'));
                                            } else {
                                              typedCity = _controller.text;
                                            }
                                            print('typedcity' + typedCity);

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
                                      refreshData();
                                    },
                                    child: Icon(
                                      Icons.place,
                                      size: 40.0,
                                      color: Color(0xFFc41a43),
                                    ),
                                  ),
                                ),
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
                            ),
                          ),
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
                        ),
                        Column(children: [
                          ExpansionPanelList(
                            animationDuration: Duration(milliseconds: 500),
                            dividerColor: Colors.grey.shade100,
                            expansionCallback: (int index, bool isExpanded) {
                              setState(() {
                                _data1[index].isExpanded = !isExpanded;
                              });
                            },
                            children: _data1.map<ExpansionPanel>((Item item) {
                              return ExpansionPanel(
                                headerBuilder:
                                    (BuildContext context, bool isExpanded) {
                                  return ListTile(
                                    title: item.headerValue,
                                  );
                                },
                                body: ListTile(
                                  focusColor: Colors.blueAccent,
                                  title: item.expandedValue,
                                ),
                                isExpanded: item.isExpanded,
                                canTapOnHeader: true,
                              );
                            }).toList(),
                          ),
                        ]),
                      ],
                    ),
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

class Item {
  bool isExpanded;
  Widget headerValue;
  Widget expandedValue;

  Item({this.isExpanded = false, this.headerValue, this.expandedValue});
}
