import 'package:flutter/material.dart';
import 'package:task/WeatherApp/Bottom_View.dart';
import 'package:task/WeatherApp/CounteryName.dart';
import 'package:task/WeatherApp/Network/Network.dart';
import 'package:task/WeatherApp/model/weather_model.dart';

class WeatherForCast extends StatefulWidget {
  @override
  _WeatherForCastState createState() => _WeatherForCastState();
}

class _WeatherForCastState extends State<WeatherForCast> {
  Future<WeatherForecastModel> forCastObject;
  String _cityName = "Egypt";

  @override
  void initState() {
    super.initState();

    forCastObject = Network().getWeatherForcast(
      cityName: _cityName,
    );

    forCastObject.then((weather) => print(weather.city));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textField(),
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

  String text = "";
  int maxLength = 7;
  var controller = TextEditingController();
  // ignore: non_constant_identifier_names
  Widget textField() {
    return Container(
        child: TextField(
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      // controller: controller,
      decoration: InputDecoration(
        hintText: "Enter City Name",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.all(10),
      ),
      onChanged: (value) {
        _cityName = value.split(",").last;
        print(_cityName);
      },
      onSubmitted: (value) {
        setState(() {
          _cityName = value;
          forCastObject = new Network().getWeatherForcast(cityName: _cityName);
        });
      },
    ));
  }
}
