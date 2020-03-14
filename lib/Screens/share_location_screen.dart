import 'package:flutter/material.dart';
import 'package:location/location.dart';

class ShareLocationScreen extends StatefulWidget {
  @override
  _ShareLocationScreenState createState() => _ShareLocationScreenState();
}

class _ShareLocationScreenState extends State<ShareLocationScreen> {
  LocationData locationData;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    locationData = await location.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Latitude: ${locationData.latitude}'),
          Text('Longitude: ${locationData.longitude}'),
        ]
      )
    );
  }
}