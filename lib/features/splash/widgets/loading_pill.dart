import 'package:docbridgeconnect/core/theme/app_colors.dart';
import 'package:docbridgeconnect/core/theme/app_radius.dart';
import 'package:docbridgeconnect/core/theme/app_spacing.dart';

import 'dart:ui';
import 'package:flutter/material.dart';

class LoadingPill extends StatelessWidget {
  const LoadingPill({
    super.key,
    required this.message,
    this.icon = Icons.sync_rounded,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.dialog,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: .55),
            borderRadius: AppRadius.dialog,
            border: Border.all(
              color: AppColors.white.withValues(alpha: .70),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary.withValues(
                  alpha: 0.08,
                ),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(
                    AppColors.primary,
                  ),
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              Icon(
                icon,
                size: 18,
                color: AppColors.primary,
              ),

              const SizedBox(width: AppSpacing.sm),

              Flexible(
                child: Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
