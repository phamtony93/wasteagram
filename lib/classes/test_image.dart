import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestImage extends StatefulWidget {
  @override
  _TestImage createState() => _TestImage();
}

class _TestImage extends State<TestImage> {

  File image;

  void getImage() async {
    File temp = await ImagePicker.pickImage(source: ImageSource.camera);
    setState( () {
      image = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Column(
        children: [
        Text('Hello world'),
      SizedBox(
        width: 50,
        height: 50,
        child:  RaisedButton(
        onPressed: () => getImage()
        )
      ),
        ]
      );
    } else {
      return Image.file(image);
    }
  }
}