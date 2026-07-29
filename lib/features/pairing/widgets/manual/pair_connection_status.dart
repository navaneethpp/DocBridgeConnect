import 'package:docbridgeconnect/core/theme/app_radius.dart';
import 'package:docbridgeconnect/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class PairConnectionStatus extends StatelessWidget {
  const PairConnectionStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        borderRadius: AppRadius.dialog,
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Text(
        'Secure connection active',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
