import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wasteagram/classes/new_post_form.dart';

class NewEntryScreen extends StatelessWidget {
  
  final File image;

  NewEntryScreen({this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
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
                    NewPostForm(image: image),
                  ]
                )
              )
            ),
          );
        }
      )
    );
  }
}


// Column(
//         children: [
//           SizedBox(
//             width: 300,
//             height:300,
//             child: Image.file(image),
//           ),
//           NewPostForm(image: image),
//         ]
//       )