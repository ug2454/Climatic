import 'package:clima/screens/loading_screen.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/address_search.dart';
import 'package:clima/services/place_service.dart';
import 'package:clima/utilities/colour_change_with_time.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:uuid/uuid.dart';

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
    // TODO: implement initState
    super.initState();
    updateUI(widget.airQualityData);
  }

  void updateUI(dynamic aqiData) {
    print(aqiData);
    cityName = aqiData['city_name'];
    aqi = aqiData['data'][0]['aqi'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ModalProgressHUD(
        progressIndicator: SpinKitCubeGrid(
          color: colourChangeWithTime.getCityTextColor(),
          size: 100.0,
          controller: AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 1200),
          ),
        ),
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
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
                          final Suggestion result = await showSearch(
                              context: context,
                              delegate: AddressSearch(sessionToken));

                          setState(() {
                            try {
                              if (result.description != null) {
                                print(
                                    'result description' + result.description);
                                setState(() {
                                  showSpinner = true;
                                });
                                _controller.text = result.description;

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

                                // searchCity();
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
                          // refreshData();
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
                Expanded(
                  child: Container(
                    width: double.infinity,
                    // color: Colors.black,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('$aqi', style: kTempTextStyle),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
