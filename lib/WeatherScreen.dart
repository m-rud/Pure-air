import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key, required this.weather}) : super(key: key);

  final Weather weather;

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
            decoration: BoxDecoration(
                color: const Color(0xffffffff),
                gradient: getGradientByMood(widget.weather)),
          ),
          Align(
            alignment: FractionalOffset.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.only(top: 45.0)),
                  Image(
                      image: AssetImage(
                          'icons/${getIconByMood(widget.weather)}.png')),
                  const Padding(padding: EdgeInsets.only(top: 41.0)),
                  Text(
                    '${DateFormat.MMMMEEEEd().format(DateTime.now())}, ${widget.weather.weatherDescription}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 14.0,
                            height: 1.2,
                            color: Colors.white,
                            fontWeight: FontWeight.w400)),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 12.0)),
                  Text(
                    '${widget.weather.temperature?.celsius?.floor().toString()}°C',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 64.0,
                            height: 1.2,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                  ),
                  Text(
                    'Felt temperature ${widget.weather.tempFeelsLike?.celsius?.floor().toString()}°C',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 14.0,
                            height: 1.2,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                  ),
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
                              Text(
                                'Pressure',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                        fontSize: 14.0,
                                        height: 1.2,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300)),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 2.0)),
                              Text(
                                '${widget.weather.pressure?.floor()} hPa',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                        fontSize: 26.0,
                                        height: 1.2,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700)),
                              )
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
                              Text(
                                'Wind',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                        fontSize: 14.0,
                                        height: 1.2,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300)),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 2.0)),
                              Text(
                                '${widget.weather.windSpeed} m/s',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                        fontSize: 26.0,
                                        height: 1.2,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 24.0)),
                  if (widget.weather.rainLastHour != null)
                    Text(
                      'Precipitation ${widget.weather.rainLastHour} mm/1h',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontSize: 14.0,
                              height: 1.2,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                    ),
                  const Padding(padding: EdgeInsets.only(top: 68.0))
                ]),
          ),
        ],
      ),
    );
  }

  String getIconByMood(Weather weather) {
    var main = weather.weatherMain;
    if (main == 'Clouds' || main == 'Drizzle' || main == 'Snow') {
      return 'weather-rain';
    } else if (main == 'Thunderstorm') {
      return 'weather-lightning';
    } else if (isNight(weather)) {
      return 'weather-moonny';
    } else {
      return 'weather-sunny';
    }
  }

  bool isNight(Weather weather) {
    return DateTime.now().isAfter(DateTime.parse(weather.sunset.toString())) ||
        DateTime.now().isBefore(DateTime.parse(weather.sunrise.toString()));
  }

  LinearGradient getGradientByMood(Weather weather) {
    var main = weather.weatherMain;
    if (main == 'Thunderstorm' || isNight(weather)) {
      return const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xff313545), Color(0xff121118)]);
    } else if (main == 'Clouds' || main == 'Drizzle' || main == 'Snow') {
      return const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xff6e6cd8), Color(0xff40A0EF), Color(0xff77e1ee)]);
    } else {
      return const LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [Color(0xff5283F0), Color(0xffCDEDD4)]);
    }
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }
}
