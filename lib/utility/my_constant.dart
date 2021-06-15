import 'package:flutter/material.dart';

class MyConstant {
  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeMyservice = '/myService';

// General
  static String appName = 'Art Connect';

// Color
  static Color primart = Color(0xff2d7511);
  static Color dart =  Color(0xff004800);
  static Color light =  Color(0xff5fa441);

  // Style
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dart,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dart,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dart,
        fontWeight: FontWeight.normal,
      );
}
