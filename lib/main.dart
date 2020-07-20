import 'package:flutter/material.dart';
import 'package:news_app/ui/news_page.dart';
import 'package:news_app/ui/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
