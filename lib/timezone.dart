import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_world_clock/Services/WorldTime.dart';
import 'Ui/colors.dart';

class LoadTimeZone extends StatefulWidget {
  const LoadTimeZone({super.key});

  @override
  State<LoadTimeZone> createState() => _LoadTimeZoneState();
}

class _LoadTimeZoneState extends State<LoadTimeZone> {
  void setupWorldTime() async {
    WorldTime instance =
        WorldTime(location: "India", flag: "india.png", url: "Asia/Kolkata");
    await instance.getTime();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDayTime': instance.isDayTime,
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitRipple(
              color: Colors.white,
              size: 86,
            ),
            SizedBox(height: 28.0),
            Text("Loading data",
                style: TextStyle(
                    fontSize: 20, color: Colors.white.withOpacity(0.7))),
            SizedBox(height: 64.0),
          ],
        ),
      ),
    );
  }
}
