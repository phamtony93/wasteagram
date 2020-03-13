
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/Screens/details_screen.dart';
import 'package:wasteagram/Screens/new_entry.dart';
import 'package:wasteagram/models/post.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreen createState() => _ListScreen();
}

class _ListScreen extends State<ListScreen> {
  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: Firestore.instance.collection('posts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  var entry = snapshot.data.documents[index];
                  Post post = Post(date: 
                    entry['date'].toString(), 
                    itemCount: entry['itemCount'], 
                    longitude: entry['longitude'], 
                    latitude: entry['latitude'], 
                    imageUrl: entry['imageUrl']
                  );
                  return ListTile(
                    title: Text(entry['date'].toString()),
                    trailing: Text(entry['itemCount'].toString()),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(post: post),
                        )
                      );
                    }
                  ); 
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openDialog(),
        child: Icon(Icons.photo),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }

  Future openDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('How to get image'),
          children: [
            SimpleDialogOption(
              onPressed: () => {
                //Navigator.pop(context),
                getImageFromCamera(),
                print('Take Photo'),
              },
              child: Text('Take Photo'),
            ),
            SimpleDialogOption(
              onPressed: () => {
                //Navigator.pop(context),
                getImageFromCameraRoll(),
                print('Camera Roll'),
              },
              child: Text('Camera Roll')
            ),
            SimpleDialogOption(
              onPressed: () => {
                Navigator.pop(context),
                print('Cancel'),
              },
              child: Text('Cancel'),
            )
          ],
        );
      }
    );
  }

  void getImageFromCamera() async {
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState( (){});
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewEntryScreen(image: image)
      )
    );
  }

  void getImageFromCameraRoll() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState( (){});

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewEntryScreen(image: image)
      )
    );
  }
}


