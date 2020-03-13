import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              child: Image.network(post.imageUrl.toString())
            ),
            Text('${post.imageUrl}'),
            Text(post.date.toString()),
            Text('Item count is ${post.itemCount.toString()}'),
            RaisedButton(
              onPressed: () => getImage(),
              child: Text('Upload Image'),
            ),
          ]
        )
      )
    );
  }

  void getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.camera);
  }
}