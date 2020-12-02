import 'package:clima/screens/loading_screen.dart';
import 'package:clima/services/address_search.dart';
import 'package:clima/services/place_service.dart';
import 'package:clima/utilities/colour_change_with_time.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:uuid/uuid.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AirQualityScreen extends StatefulWidget {
  final airQualityData;

  const AirQualityScreen({this.airQualityData});
  @override
  _AirQualityScreenState createState() => _AirQualityScreenState();
}

class _AirQualityScreenState extends State<AirQualityScreen>
    with TickerProviderStateMixin {
  ColourChangeWithTime colourChangeWithTime = ColourChangeWithTime();
  final _controller = TextEditingController();
  String typedCity;
  bool showSpinner = false;
  var cityName;
  var aqi;

  @override
  void initState() {
    super.initState();
    updateUI(widget.airQualityData);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateUI(dynamic aqiData) {
    print(aqiData);
    if (aqiData == null) {
      cityName = 'ERROR';
      aqi = 0;
      return;
    }
    cityName = aqiData['city_name'];
    aqi = aqiData['data'][0]['aqi'];
  }

  void searchCity() async {
    var cityAQI = await weatherModel.getAirQualityCity(typedCity);

    updateUI(cityAQI);
    setState(() {
      showSpinner = false;
    });
  }

  void refreshData() async {
    setState(() {
      updateUI(widget.airQualityData);
      _controller.clear();
    });
  }

  Text getHealthText(dynamic aqi) {
    if (aqi >= 0 && aqi <= 50) {
      return Text(
        'None',
        style: kHealthTextStyle,
      );
    } else if (aqi > 50 && aqi <= 100) {
      return Text(
        'Usually sensitive people should consider reduced prolonged or heavy outdoor exertion.',
        style: kHealthTextStyle,
      );
    } else if (aqi > 100 && aqi <= 150) {
      return Text(
        'Following groups should reduce prolonged or heavy outdoor exertion:\n - People with lung disease, such as asthma \n - Children and older adults\n - People who are active outdoors',
        style: kHealthTextStyle,
      );
    } else if (aqi > 150 && aqi <= 200) {
      return Text(
        'Following groups should avoid prolonged or heavy outdoor exertion:\n - People with lung disease, such as asthma \n - Children and older adults\n - People who are active outdoors \n Everyone else should limit prolonged outdoor exertion',
        style: kHealthTextStyle,
      );
    } else
      return Text(
        'Following groups should avoid all outdoor exertion:\n - People with lung disease, such as asthma \n - Children and older adults\n - People who are active outdoors \n Everyone else should limit outdoor exertion',
        style: kHealthTextStyle,
      );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: SpinKitCubeGrid(
        color: colourChangeWithTime.getCityTextColor(),
        size: 100.0,
      ),
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Air Quality Index',
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
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        flex: 6,
                        child: TextField(
                          // selectionWidthStyle: BoxWidthStyle.tight,
                          controller: _controller,

                          readOnly: true,
                          onTap: () async {
                            final sessionToken = Uuid().v4();
                            final Suggestion result = await showSearch(
                                context: context,
                                delegate: AddressSearch(sessionToken));

                            setState(() {
                              try {
                                if (result.description != null) {
                                  print('result description' +
                                      result.description);
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  _controller.text = result.description;
                                  // to filter the name till first comma to avoid error

                                  if (_controller.text.contains(',')) {
                                    typedCity = _controller.text.substring(
                                        0, _controller.text.indexOf(','));
                                  } else if (_controller.text.contains('-')) {
                                    typedCity = _controller.text.substring(
                                        0, _controller.text.indexOf('-'));
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
                      Flexible(
                        fit: FlexFit.loose,
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
                    height: 30.0,
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '$cityName',
                              textAlign: TextAlign.left,
                              style: kCityTextStyle.copyWith(
                                fontSize: 50.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        SfRadialGauge(
                          title: GaugeTitle(
                            text: 'Air Quality Index',
                            textStyle: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          axes: <RadialAxis>[
                            RadialAxis(
                              minimum: 0,
                              maximum: 500,
                              ranges: <GaugeRange>[
                                GaugeRange(
                                    startValue: 0,
                                    endValue: 50,
                                    color: Colors.green,
                                    startWidth: 10,
                                    endWidth: 10),
                                GaugeRange(
                                    startValue: 51,
                                    endValue: 100,
                                    color: Colors.yellow,
                                    startWidth: 10,
                                    endWidth: 10),
                                GaugeRange(
                                    startValue: 101,
                                    endValue: 150,
                                    color: Colors.orange,
                                    startWidth: 10,
                                    endWidth: 10),
                                GaugeRange(
                                    startValue: 151,
                                    endValue: 200,
                                    color: Colors.red,
                                    startWidth: 10,
                                    endWidth: 10),
                                GaugeRange(
                                    startValue: 201,
                                    endValue: 300,
                                    color: Colors.purple,
                                    startWidth: 10,
                                    endWidth: 10),
                                GaugeRange(
                                    startValue: 301,
                                    endValue: 500,
                                    color: Color(0xFF800000),
                                    startWidth: 10,
                                    endWidth: 10),
                              ],
                              pointers: <GaugePointer>[
                                NeedlePointer(value: aqi.toDouble())
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    angle: aqi.toDouble(), positionFactor: 0.5)
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$aqi',
                              style: kTempTextStyle.copyWith(fontSize: 50.0),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Health Advisory',
                              style: TextStyle(fontSize: 30.0),
                            ),
                            Center(child: getHealthText(aqi)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
