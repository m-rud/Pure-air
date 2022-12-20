import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pure_air/SplashScreen.dart';

class AirScreen extends StatefulWidget {
  const AirScreen({Key? key, required this.air}) : super(key: key);

  final AirQuality air;

  @override
  AirScreenState createState() => AirScreenState();
}

class AirScreenState extends State<AirScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: const Color(0xffffffff),
                gradient: getGradientByMood(widget.air)),
          ),
          Align(
            alignment: FractionalOffset.center,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              Text('Air quality',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 14.0,
                          height: 1.2,
                          color: getBackgroundTextColor(widget.air),
                          fontWeight: FontWeight.w300))),
              const Padding(padding: EdgeInsets.only(top: 2.0)),
              Text(widget.air.quality,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 22.0,
                          height: 1.2,
                          color: getBackgroundTextColor(widget.air),
                          fontWeight: FontWeight.w700))),
              const Padding(padding: EdgeInsets.only(top: 24.0)),
              CircleAvatar(
                radius: 91.0,
                backgroundColor: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text((widget.air.aqi / 200 * 100).floor().toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 64.0,
                                height: 1.2,
                                color: Colors.black,
                                fontWeight: FontWeight.w700))),
                    Text('CAQI 🛈',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 16.0,
                                height: 1.2,
                                color: Colors.black,
                                fontWeight: FontWeight.w300)))
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'NO2',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 14.0,
                                    height: 1.2,
                                    color: getBackgroundTextColor(widget.air),
                                    fontWeight: FontWeight.w300)),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 2.0)),
                          Text(
                            widget.air.no2,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 22.0,
                                    height: 1.2,
                                    color: getBackgroundTextColor(widget.air),
                                    fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    ),
                    VerticalDivider(
                      width: 24,
                      thickness: 1,
                      color: getBackgroundTextColor(widget.air),
                    ),
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'PM 10',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 14.0,
                                    height: 1.2,
                                    color: getBackgroundTextColor(widget.air),
                                    fontWeight: FontWeight.w300)),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 2.0)),
                          Text(
                            widget.air.pm10,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 22.0,
                                    height: 1.2,
                                    color: getBackgroundTextColor(widget.air),
                                    fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              Text('measuring station',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 12.0,
                          height: 1.2,
                          color: getBackgroundTextColor(widget.air),
                          fontWeight: FontWeight.w300))),
              const Padding(padding: EdgeInsets.only(top: 8.0)),
              Text(widget.air.station,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 14.0,
                          height: 1.2,
                          color: getBackgroundTextColor(widget.air),
                          fontWeight: FontWeight.w400))),
              const Padding(padding: EdgeInsets.only(top: 76))
            ]),
          ),
          Positioned(
              left: 8,
              bottom: (76.0) * 2,
              right: 0,
              top: 0,
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Stack(
                    children: [
                      ClipRect(
                        child: Align(
                            alignment: Alignment.topLeft,
                            heightFactor: 1,
                            child: getDangerValueBottom(widget.air)),
                      ),
                      ClipRect(
                        child: Align(
                            alignment: Alignment.topLeft,
                            heightFactor: 1 - widget.air.aqi / 200.floor(),
                            child: getDangerValueTop(widget.air)),
                      )
                    ],
                  ))),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 62.0, left: 10, right: 10, bottom: 14),
                      child: Divider(
                        height: 10,
                        color: getBackgroundTextColor(widget.air),
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 24),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(10.0),
                          height: 38.0,
                          child: IntrinsicHeight(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                alignment: Alignment.centerLeft,
                                image: getAdviceImage(widget.air),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(left: 8.0)),
                              Text(widget.air.advice,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontSize: 12.0,
                                          height: 1.2,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300)))
                            ],
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  bool havePermission() {
    return false;
  }

  LinearGradient getGradientByMood(AirQuality air) {
    if (air.isGood) {
      return const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xff4acf8c), Color(0xff75eda6)]);
    } else if (air.isBad) {
      return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xfffbda61), Color(0xfff76b1c)]);
    } else {
      return const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xfff4003a), Color(0xffff8888)]);
    }
  }

  Color getBackgroundTextColor(AirQuality air) {
    if (air.isGood || air.isBad) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  getDangerValueBottom(AirQuality air) {
    if (air.isGood || air.isBad) {
      return Image.asset('icons/danger-value-negative.png', scale: 0.9);
    } else {
      return Image.asset('icons/danger-value.png', scale: 0.9);
    }
  }

  getDangerValueTop(AirQuality air) {
    if (air.isGood) {
      return Image.asset('icons/danger-value-negative.png',
          color: const Color(0xff4acf8c), scale: 0.9);
    } else if (air.isBad) {
      return Image.asset('icons/danger-value-negative.png',
          color: const Color(0xfffbda61), scale: 0.9);
    } else {
      return Image.asset('icons/danger-value.png',
          color: const Color(0xfff4003a), scale: 0.9);
    }
  }

  getAdviceImage(AirQuality air) {
    if(air.isGood) {
      return const AssetImage('icons/happy.png');
    } else if (air.isBad) {
      return const AssetImage('icons/ok.png');
    } else {
      return const AssetImage('icons/sad.png');
    }
  }
}
