import 'package:docbridgeconnect/core/theme/app_colors.dart';
import 'package:docbridgeconnect/core/theme/app_spacing.dart';
import 'package:docbridgeconnect/features/splash/widgets/animated_logo.dart';
import 'package:docbridgeconnect/features/splash/widgets/loading_pill.dart';
import 'package:docbridgeconnect/features/splash/widgets/splash_background.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashBackground(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),

              const AnimatedLogo(),

              const SizedBox(height: AppSpacing.xl),

              Text(
                'DocBridge Connect',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),

              const Spacer(),

              const LoadingPill(
                message: 'Initializing Wireless Bridge...',
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
