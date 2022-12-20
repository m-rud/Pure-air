import 'package:flutter/material.dart';
import 'package:pure_air/SplashScreen.dart';
import 'package:pure_air/WeatherScreen.dart';
import 'package:weather/weather.dart';

import 'AirScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.weather, required this.air}) : super(key: key);

  final Weather weather;
  final AirQuality air;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  var _currentIndex = 0;
  late List<StatefulWidget> screens;


  @override
  void initState() {
    super.initState();
    screens = [
      AirScreen(air: widget.air),
      WeatherScreen(weather: widget.weather),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black45,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 35,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Image.asset("icons/house.png"), label: "Air", activeIcon: Image.asset("icons/house-checked.png")),
          BottomNavigationBarItem(icon: Image.asset("icons/cloud.png"), label: "Weather", activeIcon: Image.asset("icons/cloud-checked.png"))
        ],
      ),
    );
  }
}
