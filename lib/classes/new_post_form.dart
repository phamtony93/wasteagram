import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wasteagram/models/post.dart';

class NewPostForm extends StatefulWidget {
  final File image;
  final Post post = Post();
  // String imageUrl;

  NewPostForm({this.image});

  @override
  _NewPostForm createState() => _NewPostForm();
}

class _NewPostForm extends State<NewPostForm> {
  String url;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
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
            }
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: () async {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    StorageReference storageReference = 
                      FirebaseStorage.instance.ref().child(DateTime.now().toString());
                    StorageUploadTask uploadTask = storageReference.putFile(widget.image);
                    await uploadTask.onComplete;

                    Firestore.instance.collection('posts').add({
                      'itemCount': widget.post.itemCount,
                      'date': DateTime.now(),
                      'longitude': 1,
                      'latitude': 1,
                      'imageUrl': await storageReference.getDownloadURL(),
                    });
                    url = await storageReference.getDownloadURL();
                    print(url);
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