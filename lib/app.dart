import 'package:flutter/material.dart';
import 'Screens/details_screen.dart';
import 'Screens/list_screen.dart';
import 'Screens/share_location_screen.dart';
import 'Classes/test_image.dart';

class App extends StatelessWidget {

  static final routes = {
    '/': (context) => ListScreen(),
    'details_screen': (context) => DetailsScreen(),
    // '/': (context) => TestImage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      // home: TestImage(),
      routes: routes,
    );
  }
}