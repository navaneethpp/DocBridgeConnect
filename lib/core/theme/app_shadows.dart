import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static const card = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, .18),
      blurRadius: 20,
      offset: Offset(0, 10),
    ),
  ];

  static const glow = [
    BoxShadow(
      color: Color.fromRGBO(69, 239, 187, .35),
      blurRadius: 25,
    ),
  ];
}
