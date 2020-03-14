import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class TestImage extends StatefulWidget {
  @override
  _TestImage createState() => _TestImage();
}








class _TestImage extends State<TestImage> {
    LocationData locationData;
  var locationService = Location();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {   
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.DENIED) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.GRANTED) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (locationData == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Latitude: ${locationData.latitude}',
              style: Theme.of(context).textTheme.display1),
          Text('Longitude:  ${locationData.longitude}',
              style: Theme.of(context).textTheme.display1),
          RaisedButton(
            child: Text('Share'),
            onPressed: () {},
          )
        ],
      ));
    }
  }
}

//   File image;
//   Location location = new Location();
//   PermissionStatus _permissionGranted;
//   LocationData _locationData;
//   bool _serviceEnabled;

  // @override
  // void initState() {
  //   super.initState();
    
  //   checkServiceEnabled();
  //   checkPermissionGranted();
  //   if (_serviceEnabled == true && _permissionGranted == PermissionStatus.GRANTED) {
  //     getLocation();
  //   }
  // }

  
//   void checkServiceEnabled() async {
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         print('Service not enabled');
//         return;
//       }
//     }
//   }

//   void checkPermissionGranted() async {
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.DENIED) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.GRANTED) {
//         print('Permission not granted');
//         return;
//       }
//     }
//   }

//   void getLocation() async {
//     _locationData = await location.getLocation();
//     setState( (){});
//   }

//   void getImage() async {
//     File temp = await ImagePicker.pickImage(source: ImageSource.camera);
//     setState( () {
//       image = temp;
//     });
//   }

//   Widget displayLocation() {
//     print('permission: $_permissionGranted');
//     print('enabled: $_serviceEnabled');
//     print('_location: $_locationData');
//     sleep(Duration(seconds:5));
//     if (_locationData != null) {
//       return Text('Lat: ${_locationData.latitude} Long: ${_locationData.longitude}');
//     } else {
//       return Text('Location not available');
//     }
//   }

//   @override
  
//   Widget build(BuildContext context) {
//     if (image == null) {
//       return Column(
//         children: [
//         Text('Hello world'),
//       SizedBox(
//         width: 50,
//         height: 50,
//         child:  RaisedButton(
//         onPressed: () => getImage()
//         )
//       ),
//       displayLocation(),
//         ]
//       );
//     } else {
//       return Image.file(image);
//     }
//   }
// }