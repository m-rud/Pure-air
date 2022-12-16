import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
          
          ),
          Align(
            alignment: FractionalOffset.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.wb_cloudy_outlined, color: Colors.green,),
                const Padding(padding: const EdgeInsets.only(top: 5.0)),
                Text(widget.title),
                const Padding(padding: EdgeInsets.only(top: 10.0)),
                const Text('Air purity and weather \n monitoring app')
              ]
            ),
          ),
          Positioned(
            left: 0,
            bottom: 35,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              child: const Text("I'm importing your data...")
          ))
      
        ],
      ),
    );
  }

}