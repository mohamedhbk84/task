import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:task/WeatherApp/Bottom_View.dart';
import 'package:task/WeatherApp/CounteryName.dart';
import 'package:task/WeatherApp/Network/Network.dart';
import 'package:task/WeatherApp/model/weather_model.dart';
// import 'package:task/WeatherApp/Bottom_View.dart';
// import 'package:task/WeatherApp/CounteryName.dart';
// import 'package:task/WeatherApp/Bottom_View.dart';
// import 'package:task/WeatherApp/CounteryName.dart';
// import 'package:task/WeatherApp/Network/Network.dart';
// import 'package:task/WeatherApp/model/weather_model.dart';
// import 'package:geocoding/geocoding.dart';

class WeatherGps extends StatefulWidget {
  @override
  _WeatherGpsState createState() => _WeatherGpsState();
}

class _WeatherGpsState extends State<WeatherGps> {
  final Geolocator geolocator = Geolocator();
  Future<WeatherForecastModel> forCastObject;
  Position _currentPosition;
  String _currentAddress;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    forCastObject = Network().getWeatherForcast(
      cityName: _currentAddress,
    );

    forCastObject.then((weather) => print(weather.city));
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      var p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      var place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        forCastObject =
            new Network().getWeatherForcast(cityName: _currentAddress);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Location',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              if (_currentPosition != null &&
                                  _currentAddress != null)
                                Text(
                                  _currentAddress,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          Container(
            child: FutureBuilder<WeatherForecastModel>(
              future: forCastObject,
              builder: (BuildContext context,
                  AsyncSnapshot<WeatherForecastModel> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            midview(snapshot),
                          ],
                        ),
                      ),
                      bottomView(snapshot, context),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ],
      ),
    );
  }

  // var controller = TextEditingController();
  // Widget textField() {
  //   return Container(
  //       child: TextField(
  //     autofocus: true,
  //     controller: controller,
  //     textCapitalization: TextCapitalization.words,
  //     // controller: controller,
  //     decoration: InputDecoration(
  //       hintText: "Location",
  //       // prefixIcon: Icon(Icons.location_on),
  //       prefix: IconButton(
  //           icon: Icon(Icons.location_on),
  //           onPressed: () {
  //             _getCurrentLocation();
  //           }),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       contentPadding: EdgeInsets.all(10),
  //     ),

  //     onSubmitted: (value) {
  //       setState(() {
  //         _currentAddress = controller.text;
  //         _currentAddress = value;
  //         forCastObject =
  //             new Network().getWeatherForcast(cityName: _currentAddress);
  //       });
  //     },
  //   ));
  // }
}
