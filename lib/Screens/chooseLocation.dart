import 'package:flutter/material.dart';

import '../Services/WorldTime.dart';
import '../Ui/colors.dart';

class ChooseLocationScreen extends StatefulWidget {
  const ChooseLocationScreen({super.key});

  @override
  State<ChooseLocationScreen> createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen> {
  List<WorldTime> locations = [
    WorldTime(location: "India", flag: "india.png", url: "Asia/Kolkata"),
    WorldTime(
        location: "Australia", flag: "australia.png", url: "Australia/Sydney"),
    WorldTime(location: "USA", flag: "usa.png", url: "America/New_York"),
    WorldTime(location: "UK", flag: "uk.png", url: "Europe/London"),
    WorldTime(location: "Dubai", flag: "uae.png", url: "Asia/Dubai"),
    WorldTime(location: "Japan", flag: "japan.png", url: "Asia/Tokyo"),
    WorldTime(location: "Canada", flag: "canada.png", url: "America/Toronto"),
    WorldTime(location: "Germany", flag: "germany.png", url: "Europe/Berlin"),
    WorldTime(location: "Brazil", flag: "brazil.png", url: "America/Sao_Paulo"),
    WorldTime(
        location: "South Africa",
        flag: "southafrica.png",
        url: "Africa/Johannesburg"),
    WorldTime(
        location: "New Zealand",
        flag: "new-zealand.png",
        url: "Pacific/Auckland"),
    WorldTime(location: "France", flag: "france.png", url: "Europe/Paris"),
    WorldTime(location: "China", flag: "china.png", url: "Asia/Shanghai"),
  ];

  void updateTime(int index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          title: Text('Choose Location'),
        ),
        backgroundColor: Colors.blueGrey[100],
        body: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.white,
                elevation: 2,
                margin: EdgeInsets.fromLTRB(14, 15, 14, 0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(5),
                  leading: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 8),
                    child: Image.asset(
                      'assets/flags/${locations[index].flag}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(locations[index].location),
                  subtitle: Text(locations[index].url),
                  onTap: () {
                    updateTime(index);
                  },
                ),
              );
            }));
  }
}
