import 'package:docbridgeconnect/core/theme/app_motion.dart';
import 'package:docbridgeconnect/core/theme/app_spacing.dart';
import 'package:docbridgeconnect/features/pairing/widgets/manual/pair_code_input.dart';
import 'package:docbridgeconnect/features/pairing/widgets/manual/pair_connection_status.dart';
import 'package:flutter/material.dart';

class ManualPairView extends StatefulWidget {
  const ManualPairView({
    super.key,
    required this.onUseQrScanner,
    this.onValidityChanged,
  });

  final VoidCallback onUseQrScanner;

  /// Called whenever the validity of the entered pair code changes.
  /// Prepared for future validation — not acted upon yet by the parent.
  final ValueChanged<bool>? onValidityChanged;

  @override
  State<ManualPairView> createState() =>
      _ManualPairViewState();
}

class _ManualPairViewState extends State<ManualPairView> {
  void _onCodeChanged(String code) {
    // Validity hook — currently always false until validation is implemented.
    widget.onValidityChanged?.call(false);
  }

  void _onCodeCompleted(String code) {
    // Validity hook — currently always false until validation is implemented.
    widget.onValidityChanged?.call(false);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardVisible =
        MediaQuery.of(context).viewInsets.bottom > 0;

    return Column(
      children: [
        // ── Content zone ──────────────────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(
              bottom: AppSpacing.sm,
            ),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: AppMotion.normal,
                  curve: AppMotion.curve,
                  height: keyboardVisible
                      ? AppSpacing.sm
                      : AppSpacing.xl,
                ),

                Text(
                  'ENTER PAIRING CODE',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),

                AnimatedContainer(
                  duration: AppMotion.normal,
                  curve: AppMotion.curve,
                  height: keyboardVisible
                      ? AppSpacing.xss
                      : AppSpacing.sm,
                ),

                Text(
                  'Check your desktop screen for the code',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium,
                ),

                AnimatedContainer(
                  duration: AppMotion.normal,
                  curve: AppMotion.curve,
                  height: keyboardVisible
                      ? AppSpacing.md
                      : AppSpacing.xl,
                ),

                PairCodeInput(
                  onCompleted: _onCodeCompleted,
                  onChanged: _onCodeChanged,
                ),

                AnimatedContainer(
                  duration: AppMotion.normal,
                  curve: AppMotion.curve,
                  height: keyboardVisible
                      ? AppSpacing.sm
                      : AppSpacing.lg,
                ),

                const PairConnectionStatus(),
              ],
            ),
          ),
        ),

        // ── Pinned bottom action ──────────────────────────────────────────
        // Hides smoothly when keyboard is visible
        AnimatedSwitcher(
          duration: AppMotion.normal,
          switchInCurve: AppMotion.curve,
          switchOutCurve: AppMotion.curve,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
              ),
            );
          },
          child: keyboardVisible
              ? const SizedBox.shrink(
                  key: ValueKey('switch_hidden'),
                )
              : Column(
                  key: const ValueKey('switch_visible'),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: TextButton(
                        onPressed: widget.onUseQrScanner,
                        child: const Text(
                          'Switch back to QR Scanner',
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ),
        ),
      ],
    );
  }
}
