import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/screens/homepage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(
        title: 'HomePage', 
        username: '',
      ),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: FitnessAppTheme.lightPurple)),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: FitnessAppTheme.lightPurple,
        ),
      ),
    );
  }
}
