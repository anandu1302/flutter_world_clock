import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_world_clock/timezone.dart';

import '../Ui/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();

    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoadTimeZone(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              child: Image(
                image: AssetImage('assets/images/world.png'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'ZoneZee',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: colorBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
