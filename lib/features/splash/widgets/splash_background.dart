import 'dart:ui';

import 'package:docbridgeconnect/core/theme/app_colors.dart';

import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Top Left Glow
          const _AmbientGlow(
            top: -180,
            left: -140,
            size: 340,
            color: AppColors.secondary,
          ),

          // Bottom Right glow
          _AmbientGlow(
            bottom: -220,
            right: -160,
            size: 400,
            color: AppColors.primary,
          ),

          // Center Glow
          const _AmbientGlow(
            top: 220,
            left: -80,
            size: 220,
            color: AppColors.secondary,
            opacity: 0.05,
          ),

          // Glass Layer
          Positioned.fill(
            child: IgnorePointer(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 1.5,
                  sigmaY: 1.5,
                ),
                child: Container(
                  color: Colors.white.withValues(
                    alpha: 0.02,
                  ),
                ),
              ),
            ),
          ),

          // Subtle Noice Layer
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.015,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black,
                        Colors.white,
                        Colors.black,
                      ],
                    ),
                  ),
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

class _AmbientGlow extends StatelessWidget {
  const _AmbientGlow({
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.size,
    required this.color,
    this.opacity = 0.08,
  });

  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  final double size;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: IgnorePointer(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: 90,
            sigmaY: 90,
          ),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: opacity),
            ),
          ),
        ),
      ),
    );
  }
}
