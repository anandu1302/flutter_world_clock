import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String flag;
  String time;
  String url;
  bool isDayTime;

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  })  : time = '',
        isDayTime = false;

  Future<void> getTime() async {
    try {
      Response response = await get(
        Uri.parse('http://worldtimeapi.org/api/timezone/$url'),
      );
      Map data = jsonDecode(response.body);
      String dateTime = data["utc_datetime"];
      String offset = data["utc_offset"];
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(
          hours: int.parse(offset.substring(1, 3)),
          minutes: int.parse(offset.substring(4))));
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print("Caught Error : $e");
      time = "Error in Data Retrieval";
      isDayTime = false;
    }
  }
}
