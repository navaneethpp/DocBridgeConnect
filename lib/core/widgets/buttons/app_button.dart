import 'package:docbridgeconnect/core/theme/app_colors.dart';
import 'package:docbridgeconnect/core/theme/app_motion.dart';
import 'package:docbridgeconnect/core/theme/app_radius.dart';
import 'package:docbridgeconnect/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    this.icon,
    this.enabled = true,
    this.onPressed,
  });

  final String text;
  final IconData? icon;
  final bool enabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isEnabled = enabled && onPressed != null;

    return AnimatedContainer(
      duration: AppMotion.normal,
      curve: Curves.easeInOut,
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: isEnabled
            ? AppColors.primary.withValues(alpha: 0.82)
            : AppColors.primary.withValues(alpha: .18),
        borderRadius: AppRadius.dialog,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: AppRadius.dialog,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(
                      color: isEnabled
                          ? AppColors.white
                          : AppColors.white.withValues(
                              alpha: .45,
                            ),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
              ),

              if (icon != null) ...[
                const SizedBox(width: AppSpacing.sm),

                Icon(
                  icon,
                  size: 18,
                  color: isEnabled
                      ? AppColors.white
                      : AppColors.white.withValues(
                          alpha: .45,
                        ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
