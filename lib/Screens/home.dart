import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_world_clock/Services/WorldTime.dart';
import 'package:flutter_world_clock/Ui/colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<dynamic, dynamic> data = {};
  bool hasInternet = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkInternetAndFetchTime();
  }

  Future<void> _checkInternetAndFetchTime() async {
    setState(() {
      isLoading = true;
    });

    // Check for internet connection
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        hasInternet = false;
        isLoading = false;
      });
    } else {
      setState(() {
        hasInternet = true;
      });

      WorldTime instance =
          WorldTime(location: 'India', flag: 'india.png', url: 'Asia/Kolkata');
      await instance.getTime();

      setState(() {
        data = {
          'time': instance.time,
          'location': instance.location,
          'flag': instance.flag,
          'isDayTime': instance.isDayTime,
        };
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Check if the data was passed from another page
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;

    String bgImage = data["isDayTime"] ? "day.jpg" : "night.png";

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasInternet
              ? Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/$bgImage'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.3,
                      ),
                      GestureDetector(
                        onTap: () async {
                          dynamic result =
                              await Navigator.pushNamed(context, '/location');
                          if (result != null) {
                            setState(() {
                              data = {
                                'time': result["time"],
                                'location': result["location"],
                                'flag': result["flag"],
                                'isDayTime': result["isDayTime"],
                              };
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit_location,
                              size: 26,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Change Location',
                              style: TextStyle(fontSize: 18, color: colorBlack),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            data["location"],
                            style:
                                TextStyle(fontSize: 28.0, letterSpacing: 2.0),
                          ),
                          SizedBox(width: 14),
                          Image.asset('assets/flags/${data["flag"]}',
                              height: 40),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        data["time"],
                        style: TextStyle(fontSize: 42),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wifi_off, size: 100, color: Colors.grey),
                      SizedBox(height: 20),
                      Text(
                        'No Internet Connection',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            bgColor,
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size(
                              size.width * 0.4,
                              size.height * 0.06,
                            ),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          _checkInternetAndFetchTime();
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                ),
    );
  }
}
