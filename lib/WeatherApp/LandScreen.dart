import 'package:flutter/material.dart';
import 'package:task/WeatherApp/WeatherForCast.dart';
import 'package:task/WeatherApp/WeatherGps.dart';

class LandScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          button(
              context: context,
              text: "Search User",
              onClick: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WeatherForCast()));
              }),
          SizedBox(
            height: 25,
          ),
          button(
              context: context,
              text: "GPS",
              onClick: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WeatherGps()));
              }),
        ],
      ),
    );
  }

  Widget button({Function onClick, String text, context}) => GestureDetector(
        onTap: onClick,
        child: Container(
          width: MediaQuery.of(context).size.width - 20,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.cyan.shade400.withOpacity(.6),
              borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
      );
}
