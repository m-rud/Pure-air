import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pure_air/MyHomePage.dart';
import 'package:pure_air/PermissionScreen.dart';
import 'package:weather/weather.dart';

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
    if(permissionDenied()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const PermissionScreen()));
    } else {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) { 
        executeOnceAfterBuild();
      });
    }
  }

  bool permissionDenied() {
    return false;
  }

  void executeOnceAfterBuild() async {
    WeatherFactory wf = WeatherFactory("b9b26b0a2dc98163b8412c022f815653", language: Language.ENGLISH);
    Weather w = await wf.currentWeatherByCityName("Lublin");
    log(w.toJson().toString());

  }
}
