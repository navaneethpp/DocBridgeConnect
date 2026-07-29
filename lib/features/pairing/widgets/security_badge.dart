import 'package:docbridgeconnect/core/theme/app_colors.dart';
import 'package:docbridgeconnect/core/theme/app_radius.dart';
import 'package:docbridgeconnect/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

enum SecurityStatus {
  encrypted,
  verifying,
  connecting,
  disconnected,
  insecure,
}

class SecurityBadge extends StatefulWidget {
  const SecurityBadge({
    super.key,
    this.status = SecurityStatus.encrypted,
    this.isGlowing = false,
  });

  final SecurityStatus status;
  final bool isGlowing;

  @override
  State<SecurityBadge> createState() => _SecurityBadgeState();
}

class _SecurityBadgeState extends State<SecurityBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _glowAnimation = Tween<double>(begin: 0.2, end: 0.8).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    if (widget.isGlowing) {
      _glowController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant SecurityBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isGlowing != oldWidget.isGlowing) {
      if (widget.isGlowing) {
        _glowController.repeat(reverse: true);
      } else {
        _glowController.stop();
        _glowController.reset();
      }
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = _SecurityBadgeStyle.fromStatus(widget.status);

    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        final glowAlpha = widget.isGlowing ? _glowAnimation.value : 0.0;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: style.backgroundColor,
            borderRadius: AppRadius.dialog,
            border: Border.all(color: style.borderColor),
            boxShadow: widget.isGlowing
                ? [
                    BoxShadow(
                      color: style.color.withValues(alpha: 0.4 * glowAlpha),
                      blurRadius: 12,
                      spreadRadius: 2 * glowAlpha,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(style.icon, size: 18, color: style.color),
              const SizedBox(width: AppSpacing.sm),
              Text(
                style.label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: style.color,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SecurityBadgeStyle {
  const _SecurityBadgeStyle({
    required this.icon,
    required this.label,
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color backgroundColor;
  final Color borderColor;

  factory _SecurityBadgeStyle.fromStatus(
    SecurityStatus status,
  ) {
    switch (status) {
      case SecurityStatus.encrypted:
        return _SecurityBadgeStyle(
          icon: Icons.verified_user_rounded,
          label: 'END-TO-END ENCRYPTED',
          color: AppColors.success,
          backgroundColor: AppColors.success.withValues(
            alpha: .12,
          ),
          borderColor: AppColors.success.withValues(
            alpha: .30,
          ),
        );

      case SecurityStatus.verifying:
        return _SecurityBadgeStyle(
          icon: Icons.shield_outlined,
          label: 'VERIFYING CONNECTION',
          color: AppColors.warning,
          backgroundColor: AppColors.warning.withValues(
            alpha: .12,
          ),
          borderColor: AppColors.warning.withValues(
            alpha: .30,
          ),
        );

      case SecurityStatus.connecting:
        return _SecurityBadgeStyle(
          icon: Icons.wifi_tethering_rounded,
          label: 'CONNECTING...',
          color: AppColors.info,
          backgroundColor: AppColors.info.withValues(
            alpha: .12,
          ),
          borderColor: AppColors.info.withValues(
            alpha: .30,
          ),
        );

      case SecurityStatus.disconnected:
        return _SecurityBadgeStyle(
          icon: Icons.portable_wifi_off_rounded,
          label: 'WAITING FOR CONNECTION',
          color: AppColors.textSecondary,
          backgroundColor: AppColors.textSecondary
              .withValues(alpha: .10),
          borderColor: AppColors.textSecondary.withValues(
            alpha: .25,
          ),
        );

      case SecurityStatus.insecure:
        return _SecurityBadgeStyle(
          icon: Icons.warning_amber_rounded,
          label: 'UNSECURED CONNECTION',
          color: AppColors.error,
          backgroundColor: AppColors.error.withValues(
            alpha: .12,
          ),
          borderColor: AppColors.error.withValues(
            alpha: .30,
          ),
        );
    }
  }
}
