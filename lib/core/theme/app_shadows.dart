import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black.withValues(alpha: .15),
      blurRadius: 30,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> glow = [
    BoxShadow(
      color: const Color(0xFF00E5A8).withValues(alpha: .15),
      blurRadius: 40,
      spreadRadius: 2,
    ),
  ];
}
