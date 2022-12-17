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
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [Color(0xff6e6cd8), Color(0xff77e1ee)])),
          ),
          Align(
            alignment: FractionalOffset.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.only(top: 45.0)),
                  const Image(image: AssetImage('icons/weather-sunny.png')),
                  const Padding(padding: EdgeInsets.only(top: 41.0)),
                  const Text('Monday 31.05, 9.00PM sunny'),
                  const Padding(padding: EdgeInsets.only(top: 12.0)),
                  const Text('14°C'),
                  const Text('sensed temperature 13°C'),
                  const Padding(padding: EdgeInsets.only(top: 24.0)),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text('Pressure'),
                                Padding(padding: EdgeInsets.only(top: 2.0)),
                                Text('1020 hPa')
                              ],
                            ),
                        ),
                        const VerticalDivider(
                          width: 48,
                          thickness: 1,
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text('Wind'),
                              Padding(padding: EdgeInsets.only(top: 2.0)),
                              Text('16 km/h')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 24.0)),
                  const Text('Precipitation 0,1 mm/12h'),
                  const Padding(padding: EdgeInsets.only(top: 68.0))

                ]),
          ),
        ],
      ),
    );
  }
}
