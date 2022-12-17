import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
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
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Color(0xff6e6cd8), Color(0xff40A0EF), Color(0xff77e1ee)])),
          ),
          Align(
            alignment: FractionalOffset.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.only(top: 45.0)),
                  const Image(image: AssetImage('icons/weather-sunny.png')),
                  const Padding(padding: EdgeInsets.only(top: 41.0)),
                  Text('Monday 31.05, 9.00PM sunny',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 14.0,
                      height: 1.2,
                      color: Colors.white,
                      fontWeight: FontWeight.w400
                    )
                  ),),
                  const Padding(padding: EdgeInsets.only(top: 12.0)),
                  Text('14°C',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 64.0,
                            height: 1.2,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                        )
                    ),),
                  Text('Sensed temperature 13°C',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 14.0,
                            height: 1.2,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                        )
                    ),),
                  const Padding(padding: EdgeInsets.only(top: 24.0)),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Pressure',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontSize: 14.0,
                                          height: 1.2,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300
                                      )
                                  ),),
                                const Padding(padding: EdgeInsets.only(top: 2.0)),
                                Text('1020 hPa',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontSize: 26.0,
                                          height: 1.2,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700
                                      )
                                  ),)
                              ],
                            ),
                        ),
                        const VerticalDivider(
                          width: 48,
                          thickness: 1,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Wind',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                        fontSize: 14.0,
                                        height: 1.2,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    )
                                ),),
                              const Padding(padding: EdgeInsets.only(top: 2.0)),
                              Text('16 km/h',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                        fontSize: 26.0,
                                        height: 1.2,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700
                                    )
                                ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 24.0)),
                  Text('Precipitation 0,1 mm/12h',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 14.0,
                            height: 1.2,
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                        )
                    ),),
                  const Padding(padding: EdgeInsets.only(top: 68.0))

                ]),
          ),
        ],
      ),
    );
  }
}
