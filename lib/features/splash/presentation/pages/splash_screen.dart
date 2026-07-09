import 'package:docbridgeconnect/core/constants/app_constants.dart';
import 'package:docbridgeconnect/core/theme/app_colors.dart';
import 'package:docbridgeconnect/core/theme/app_spacing.dart';
// import 'package:docbridgeconnect/core/widgets/logo.dart';

import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.splashScreen,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: Column(
              children: [
                // Spacer
                const Spacer(),
                // Logo
                // const Logo(width: Appconstants.logoSize),
                // Gap
                const SizedBox(height: AppSpacing.md),
                // App Name
                Text(
                  Appconstants.appName,
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(color: AppColors.primary),
                ),
                // Tagline
                Text(
                  Appconstants.appTagLine,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(
                        color: AppColors.secondary,
                      ),
                ),
                // Spacer
                const Spacer(),
                // Version
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppSpacing.lg,
                  ),
                  child: Text(
                    "Version: ${Appconstants.appVersion}",
                    style: theme.textTheme.labelSmall
                        ?.copyWith(
                          color: AppColors.secondary,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
