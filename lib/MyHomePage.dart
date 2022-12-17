import 'package:flutter/material.dart';
import 'package:pure_air/WeatherScreen.dart';

import 'AirScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  var _currentIndex = 0;
  final screens = [
    const AirScreen(),
    const WeatherScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.air), label: "Air"),
          BottomNavigationBarItem(icon: Icon(Icons.wb_cloudy), label: "Weather")
        ],
      ),
    );
  }
}
