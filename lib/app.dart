import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'Screens/details_screen.dart';
import 'Screens/list_screen.dart';

class App extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  static final routes = {
    '/': (context) => ListScreen(),
    'details_screen': (context) => DetailsScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      routes: routes,
      navigatorObservers: [
        observer,
      ],
    );
  }
}