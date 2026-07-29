import 'package:docbridgeconnect/core/theme/app_colors.dart';
import 'package:docbridgeconnect/core/theme/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PairCodeInput extends StatelessWidget {
  const PairCodeInput({
    super.key,
    required this.onCompleted,
    this.onChanged,
  });

  final ValueChanged<String> onCompleted;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final defaultPinTheme = PinTheme(
      width: 52,
      height: 60,
      textStyle: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.button,
        border: Border.all(color: AppColors.border),
      ),
    );

    return Pinput(
      length: 6,
      autofocus: true,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyDecorationWith(
        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyDecorationWith(
        border: Border.all(color: AppColors.border),
      ),
      onCompleted: onCompleted,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
    );
  }
}
