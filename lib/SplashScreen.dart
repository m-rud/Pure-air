import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pure_air/MyHomePage.dart';
import 'package:pure_air/PermissionScreen.dart';
import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                color: Color(0xffffffff),
                gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [Color(0xff6671e5), Color(0xff4852d9)])),
          ),
          Align(
            alignment: FractionalOffset.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(image: AssetImage('icons/cloud-sun.png')),
                  const Padding(padding: EdgeInsets.only(top: 5.0)),
                  Text(Strings.appTitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 42.0,
                        color: Colors.white,
                      ))),
                  const Padding(padding: EdgeInsets.only(top: 10.0)),
                  Text('Air purity and weather \n monitoring app',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ))),
                ]),
          ),
          Positioned(
              left: 0,
              bottom: 35,
              right: 0,
              child: Container(
                  alignment: Alignment.center,
                  child: Text("I'm importing your data...",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 18.0,
                        color: Colors.white,
                      )))))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  Future checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PermissionScreen()));
    } else {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        executeOnceAfterBuild();
      });
    }
  }

  void executeOnceAfterBuild() async {
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.lowest,
        forceAndroidLocationManager: true,
        timeLimit: const Duration(seconds: 5))
        .then((value) => {loadLocationData(value)})
        .onError((error, stackTrace) =>
    {
      Geolocator.getLastKnownPosition(forceAndroidLocationManager: true)
          .then((value) => {
            loadLocationData(value!)
    })
    });
  }

  loadLocationData(Position value) async {
    var lat = value.latitude;
    var lon = value.longitude;
    log("${lat.toString()} x ${lon.toString()}");

    WeatherFactory wf = WeatherFactory("26c0c329eb6b31d05e42cc6231061659",
        language: Language.ENGLISH);
    Weather w = await wf.currentWeatherByLocation(lat, lon);
    log(w.toJson().toString());

    var keyword = 'geo:$lat;$lon';
    var key = '9bbd4f5eb47447a83f37258dc555b8dd901e1b7e';
    String endpoint = 'https://api.waqi.info/feed/';
    String url = '$endpoint/$keyword?token=$key';

    http.Response response = await http.get(Uri.parse(url));
    log(response.body.toString());

    Map<String, dynamic> jsonBody = jsonDecode(response.body);
    AirQuality aq = AirQuality(jsonBody);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(weather: w, air: aq)));
  }

}

class AirQuality {
  bool isGood = false;
  bool isBad = false;
  String quality = "";
  String advice = "";
  int aqi = 0;
  String no2 = "";
  String pm10 = "";
  String station = "";

  AirQuality(Map<String, dynamic> jsonBody) {
    aqi = int.tryParse(jsonBody['data']['aqi'].toString()) ?? -1;
    no2 = jsonBody['data']['iaqi'].containsKey('no2')
        ? jsonBody['data']['iaqi']['no2']['v'].toString()
        : "?";
    pm10 = jsonBody['data']['iaqi'].containsKey('pm10')
        ? jsonBody['data']['iaqi']['pm10']['v'].toString()
        : "?";
    station = jsonBody['data']['city']['name'].toString();
    setupLevel(aqi);
  }

  void setupLevel(int aqi) {
    if (aqi <= 100) {
      quality = 'Very good';
      advice = "Take advantage of clean air and go outside";
      isGood = true;
    } else if (aqi <= 150) {
      quality = 'Not too good';
      advice = "If you can, stay home, do things online";
      isBad = false;
    } else {
      quality = 'Very bad!';
      advice = "Definitely stay home!";
    }
  }
}
