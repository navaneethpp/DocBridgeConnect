import 'package:docbridgeconnect/core/theme/app_colors.dart';
import 'package:docbridgeconnect/core/theme/app_motion.dart';
import 'package:docbridgeconnect/core/theme/app_radius.dart';
import 'package:docbridgeconnect/core/theme/app_spacing.dart';
import 'package:docbridgeconnect/features/pairing/models/pairing_status.dart';
import 'package:docbridgeconnect/features/pairing/widgets/status/pairing_status_indicator.dart';
import 'package:flutter/material.dart';

class WaitingStatus extends StatelessWidget {
  const WaitingStatus({
    super.key,
    required this.status,
    this.onRetry,
    this.onScanQrAgain,
  });

  final PairingStatus status;
  final VoidCallback? onRetry;
  final VoidCallback? onScanQrAgain;

  @override
  Widget build(BuildContext context) {
    final config = status.config;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            PairingStatusIndicator(
              config: config,
              size: 18.0,
            ),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: AnimatedSwitcher(
                duration: AppMotion.normal,
                switchInCurve: AppMotion.curve,
                switchOutCurve: AppMotion.curve,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      axis: Axis.horizontal,
                      child: child,
                    ),
                  );
                },
                child: Text(
                  config.title,
                  key: ValueKey(config.title),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: config.iconColor == AppColors.error
                            ? AppColors.error
                            : config.iconColor == AppColors.warning
                                ? AppColors.warning
                                : AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                ),
              ),
            ),
          ],
        ),
        if (config.subtitle != null) ...[
          const SizedBox(height: AppSpacing.xss),
          AnimatedSwitcher(
            duration: AppMotion.normal,
            switchInCurve: AppMotion.curve,
            switchOutCurve: AppMotion.curve,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: Text(
              config.subtitle!,
              key: ValueKey(config.subtitle),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary.withValues(alpha: 0.8),
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ),
        ],
        if (config.showRetryButton || config.showScanQrButton) ...[
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            alignment: WrapAlignment.center,
            children: [
              if (config.showRetryButton && onRetry != null)
                OutlinedButton.icon(
                  onPressed: onRetry,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.button,
                    ),
                  ),
                  icon: const Icon(Icons.refresh_rounded, size: 16),
                  label: const Text('Retry'),
                ),
              if (config.showScanQrButton && onScanQrAgain != null)
                OutlinedButton.icon(
                  onPressed: onScanQrAgain,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.button,
                    ),
                  ),
                  icon: const Icon(Icons.qr_code_scanner_rounded, size: 16),
                  label: const Text('Scan QR Again'),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
