import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wasteagram/classes/new_post_form.dart';
import 'package:wasteagram/functions/padding.dart';

class NewEntryScreen extends StatelessWidget {
  
  final File image;
  final String imageUrl;

  NewEntryScreen({this.image, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: EdgeInsets.only(top: padding(context)),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 300,
                        height:300,
                        child: Image.file(image),
                      ),
                      NewPostForm(imageUrl: imageUrl),
                    ]
                  )
                )
              ),
            )
          );
        }
      )
    );
  }
}
