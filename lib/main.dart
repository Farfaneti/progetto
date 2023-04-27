import 'package:flutter/material.dart';
import 'package:progetto/screens/contents.dart';
import 'package:progetto/screens/graphs_page.dart';
import 'package:progetto/screens/homepage.dart';
import 'package:progetto/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(
        title: 'HomePage',
      ),
    );
  }
}
