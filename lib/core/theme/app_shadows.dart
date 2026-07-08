import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static List<BoxShadow> card = [
    BoxShadow(
      // TODO: check withOpacity
      color: Colors.black.withOpacity(
        .15,
      ),
      blurRadius: 30,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> glow = [
    BoxShadow(
      // TODO: check withOpacity
      color: const Color(
        0xFF00E5A8,
      ).withOpacity(.15),
      blurRadius: 40,
      spreadRadius: 2,
    ),
  ];
}
