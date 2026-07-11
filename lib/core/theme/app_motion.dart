import 'package:flutter/material.dart';

class AppMotion {
  AppMotion._();

  static const fast = Duration(milliseconds: 150);
  static const normal = Duration(milliseconds: 300);
  static const slow = Duration(milliseconds: 600);

  static const splashEntrance = Duration(
    milliseconds: 1200,
  );

  static const floating = Duration(seconds: 4);
  static const splashDuration = Duration(seconds: 3);

  static const curve = Curves.easeInOut;
}
