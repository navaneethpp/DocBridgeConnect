import 'package:docbridgeconnect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Top ambiennt glow
          Positioned(
            top: -180,
            left: -120,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withValues(
                  alpha: 0.08,
                ),
              ),
            ),
          ),
          // Bottom ambient glow
          Positioned(
            bottom: -220,
            right: -140,
            child: Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(
                  alpha: 0.08,
                ),
              ),
            ),
          ),

          SafeArea(child: child),
        ],
      ),
    );
  }
}
