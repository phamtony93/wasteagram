import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/Screens/details_screen.dart';
import 'package:wasteagram/Screens/new_entry.dart';
import 'package:wasteagram/models/post.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreen createState() => _ListScreen();
}

class _ListScreen extends State<ListScreen> {
  File image;
  // int totalCount = 0;

  @override
  void initState() {
    super.initState();
    // getTotalCount();
  }


  // void getTotalCount() {
  //   Firestore.instance.collection('posts').snapshots();
  // };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: StreamBuilder(
            stream: Firestore.instance.collection('posts').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.documents.length > 0 && snapshot.data.documents != null) {
                var totalCount = 0;
                var index;
                for (index = 0; index < snapshot.data.documents.length; index++) {
                  if (snapshot.data.documents[index]['itemCount'] == null) {
                  } else {
                    totalCount += snapshot.data.documents[index]['itemCount'];
                  }
                }
                return Text('Wasteagram - $totalCount');
              } else {
                return Text('Wasteagram');
              }
            }
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: Firestore.instance.collection('posts').orderBy('date', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  var entry = snapshot.data.documents[index];
                  Post post = Post(
                    date: entry['date'].toDate(), 
                    itemCount: entry['itemCount'], 
                    longitude: entry['longitude'].toString(), 
                    latitude: entry['latitude'].toString(), 
                    imageUrl: entry['imageUrl']
                  );
                  return ListTile(
                    title: Text(DateFormat.yMMMMEEEEd().format(entry['date'].toDate())),
                    trailing: Text(entry['itemCount'].toString()),
                    onTap: () {
                      Navigator.push(
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
      floatingActionButton: Semantics(
        child: FloatingActionButton(
          onPressed: () => openDialog(),
          child: Icon(Icons.photo),
        ),
        button: true,
        onTapHint: 'Choose a photo',
        enabled: true,
        textField: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }

  Future openDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select an image'),
          children: [
            Semantics(
              child: SimpleDialogOption(
                onPressed: () => {
                  getImageFromCamera(),
                },
                child: Text('Take Photo'),
              ),
              button: true,
              enabled: true,
              onTapHint: 'Take photo from camera',
            ),
            Semantics(
              child: SimpleDialogOption(
                onPressed: () => {
                  getImageFromCameraRoll(),
                },
                child: Text('Camera Roll')
              ),
              button: true,
              enabled: true,
              onTapHint: 'Take photo from gallery',
            ),
            Semantics(
              child: SimpleDialogOption(
                onPressed: () => {
                  Navigator.pop(context),
                },
                child: Text('Cancel'),
              ),
              button: true,
              enabled: true,
              onTapHint: 'Cancel photo selection',
            ),
          ],
        );
      }
    );
  }

  void getImageFromCamera() async {
    String imageUrl;
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      StorageReference storageReference = FirebaseStorage.instance.ref().child(DateTime.now().toString());
      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      imageUrl = await storageReference.getDownloadURL();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NewEntryScreen(image: image, imageUrl: imageUrl)
        )
      );
    }
  }

  void getImageFromCameraRoll() async {
    String imageUrl;
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      StorageReference storageReference = FirebaseStorage.instance.ref().child(DateTime.now().toString());
      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      imageUrl = await storageReference.getDownloadURL();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NewEntryScreen(image: image, imageUrl:imageUrl)
        )
      );
    }
  }

  // String uploadImage(image) async {
  //   String imageUrl;
  //   StorageReference storageReference = FirebaseStorage.instance.ref().child(DateTime.now().toString());
  //   StorageUploadTask uploadTask = storageReference.putFile(image);
  //   await uploadTask.onComplete;
  //   imageUrl =  await storageReference.getDownloadURL();
  //   return imageUrl;
  // }
}


