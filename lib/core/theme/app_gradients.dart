import 'package:docbridgeconnect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppGradients {
  AppGradients._();

  static const primary = LinearGradient(
    colors: [AppColors.secondary, AppColors.primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const glass = LinearGradient(
    colors: [
      Color.fromRGBO(255, 255, 255, 0.08),
      Color.fromRGBO(255, 255, 255, 0.02),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
