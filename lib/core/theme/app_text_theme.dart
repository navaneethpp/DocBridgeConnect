import 'package:docbridgeconnect/core/theme/app_colors.dart';
import 'package:docbridgeconnect/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme dark = TextTheme(
    displayLarge: AppTypography.display.copyWith(
      color: AppColors.primary,
    ),
    headlineMedium: AppTypography.headline.copyWith(
      color: AppColors.textPrimary,
    ),
    titleLarge: AppTypography.title.copyWith(
      color: AppColors.textPrimary,
    ),
    bodyLarge: AppTypography.body.copyWith(
      color: AppColors.textPrimary,
    ),
    bodyMedium: AppTypography.body.copyWith(
      color: AppColors.textSecondary,
    ),
  );
}
