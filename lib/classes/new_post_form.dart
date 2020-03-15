import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:wasteagram/models/post.dart';

class NewPostForm extends StatefulWidget {
  // final File image;
  String imageUrl;
  final Post post = Post();

  NewPostForm({this.imageUrl});

  @override
  _NewPostForm createState() => _NewPostForm();
}

class _NewPostForm extends State<NewPostForm> {
  String url;
  Location location;
  // LocationData _locationData;
  // bool _serviceEnabled;
  PermissionStatus permissionStatus;
  final formKey = GlobalKey<FormState>();
  LocationData locationData;
  var locationService = Location();



  @override
  void initState() {
    super.initState();

    // checkServiceEnabled();
    // checkPermissionGranted();
    // if (_serviceEnabled == true && permissionStatus == PermissionStatus.GRANTED) {
      // getLocation();
    // }
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

  // void checkServiceEnabled() async {
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       print('Service not enabled.');
  //       return;
  //     }
  //   }
  // }

  // void checkPermissionGranted() async {
  //   permissionStatus = await location.hasPermission();
  //   if (permissionStatus == PermissionStatus.DENIED) {
  //     permissionStatus = await location.requestPermission();
  //     if (permissionStatus != PermissionStatus.GRANTED) {
  //       print('Permission not granted.');
  //       return;
  //     }
  //   }
  // }

  // void getLocation() async {
  //   _locationData = await location.getLocation();
  //   setState( (){});
  // }

  @override
  Widget build(BuildContext context) {
    if (locationData == null) {
      return CircularProgressIndicator();
    } else {
      return Form(
        key: formKey,
        child: Column(
          children: [
            Container(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Count',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a count';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                widget.post.itemCount = int.parse(value);
              },
              keyboardType: TextInputType.number,
            ),
            Container(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      // StorageReference storageReference = 
                      //   FirebaseStorage.instance.ref().child(DateTime.now().toString());
                      // StorageUploadTask uploadTask = storageReference.putFile(widget.image);
                      // await uploadTask.onComplete;
                      Firestore.instance.collection('posts').add({
                        'itemCount': widget.post.itemCount,
                        'date': DateTime.now(),
                        'longitude': locationData.longitude.toString(),
                        'latitude': locationData.latitude.toString(),
                        'imageUrl': widget.imageUrl,
                      });
                      // url = await storageReference.getDownloadURL();
                      // print(url);
                      Navigator.pop(context);
                      print('hello world');
                    }
                  },
                  child: Text('Upload')
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')
                )
              ]
            )
          ]
        ),
      );
    }
  }
}