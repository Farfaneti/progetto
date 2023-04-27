import 'package:flutter/material.dart';

class FitnessAppTheme {
  FitnessAppTheme._();
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color.fromARGB(255, 139, 26, 201);
  static const Color purple = Color.fromARGB(255, 178, 86, 235);

  static const Color nearlyBlue = Color.fromARGB(255, 154, 92, 170);
  static const Color nearlyBlack = Color.fromARGB(255, 45, 33, 51);
  static const Color grey = Color.fromARGB(255, 93, 58, 96);
  static const Color dark_grey = Color.fromARGB(255, 64, 49, 68);

  static const Color darkText = Color.fromARGB(255, 53, 37, 64);
  static const Color darkerText = Color.fromARGB(255, 44, 23, 53);
  static const Color lightText = Color.fromARGB(255, 81, 53, 114);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color.fromARGB(255, 208, 205, 211);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Roboto';

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: nearlyBlue,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: nearlyDarkBlue,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    letterSpacing: 0.18,
    color: purple,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: -0.04,
    color: grey,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}
