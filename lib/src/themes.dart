import 'package:flutter/material.dart';

final mainTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.purple,
    primaryColor: Colors.purple,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(fontSize: 14.0),
    ),
    scaffoldBackgroundColor: Colors.purple[50]);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: Colors.purple,
  primarySwatch: Colors.purple,
  primaryColor: Colors.purple,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    bodyText2: TextStyle(fontSize: 14.0),
  ),
);
