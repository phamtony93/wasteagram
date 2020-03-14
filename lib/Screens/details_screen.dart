import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:wasteagram/models/post.dart';

class DetailsScreen extends StatelessWidget {

  Post post;
  File image;

  DetailsScreen({this.post});
  
  @override 
  Widget build(BuildContext context) {
    // final entry = ModalRoute.of(context).settings.arguments;
    print('entry is $post');
    return 
    Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
      ),
      body: SafeArea(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Semantics(
              child: Container(
                width: 300,
                height: 300,
                child: Image.network(post.imageUrl.toString())
              ),
              readOnly: true,
              image: true,
              label: 'Photo of waste',
            ),
            // Text('${post.imageUrl}'),
            Text(DateFormat.yMMMMEEEEd().format(post.date).toString()),
            Text('Item count: ${post.itemCount.toString()}'),
            Text('Location taken: (${post.latitude}, ${post.longitude})'),
          ]
        )
      )
    );
  }

  void getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.camera);
  }
}