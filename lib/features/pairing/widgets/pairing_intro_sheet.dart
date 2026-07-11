import 'package:docbridgeconnect/core/theme/app_colors.dart';
import 'package:docbridgeconnect/core/theme/app_radius.dart';
import 'package:docbridgeconnect/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// A premium Material 3 bottom sheet that introduces DocBridge Connect
/// to first-time users.
///
/// Usage:
/// ```dart
/// PairingIntroSheet.show(context);
/// ```
class PairingIntroSheet extends StatelessWidget {
  const PairingIntroSheet._();

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  /// Opens the introduction bottom sheet.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: AppRadius.xl,
          topRight: AppRadius.xl,
        ),
      ),
      backgroundColor: AppColors.surface,
      useSafeArea: true,
      builder: (_) => const PairingIntroSheet._(),
    );
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────────────────
              _SheetHeader(textTheme: textTheme),

              const SizedBox(height: AppSpacing.xl),

              // ── Feature cards ───────────────────────────────────────────
              _FeatureCard(
                emoji: '📱',
                title: 'Secure Pairing',
                description:
                    'Pair your phone with the DocBridge Web Application '
                    'using a QR Code or Pair Code.',
                colorScheme: colorScheme,
                textTheme: textTheme,
              ),

              const SizedBox(height: AppSpacing.md),

              _FeatureCard(
                emoji: '📷',
                title: 'Live Camera Preview',
                description:
                    'Your phone streams a real-time camera preview '
                    'directly to your computer.',
                colorScheme: colorScheme,
                textTheme: textTheme,
              ),

              const SizedBox(height: AppSpacing.md),

              _FeatureCard(
                emoji: '📄',
                title: 'Capture & Scan',
                description:
                    'Capture high-quality documents from the web application '
                    'with full remote control.',
                colorScheme: colorScheme,
                textTheme: textTheme,
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Dismiss button ──────────────────────────────────────────
              _DismissButton(
                colorScheme: colorScheme,
                textTheme: textTheme,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Private sub-widgets
// ═══════════════════════════════════════════════════════════════════════════════

class _SheetHeader extends StatelessWidget {
  const _SheetHeader({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to DocBridge Connect',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Turn your smartphone into a professional wireless document camera.',
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.emoji,
    required this.title,
    required this.description,
    required this.colorScheme,
    required this.textTheme,
  });

  final String emoji;
  final String title;
  final String description;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.card,
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Emoji badge
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(
                alpha: 0.12,
              ),
              borderRadius: const BorderRadius.all(
                AppRadius.md,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 22),
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _DismissButton extends StatelessWidget {
  const _DismissButton({
    required this.colorScheme,
    required this.textTheme,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () => Navigator.of(context).pop(),
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: AppColors.black,
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.md,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.button,
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
        child: const Text('Got it'),
      ),
    );
  }
}
