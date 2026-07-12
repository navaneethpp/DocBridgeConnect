import 'package:docbridgeconnect/core/theme/app_colors.dart';
import 'package:docbridgeconnect/core/theme/app_motion.dart';
import 'package:docbridgeconnect/core/theme/app_radius.dart';
import 'package:flutter/material.dart';

class PairingTabSelector extends StatelessWidget {
  const PairingTabSelector({
    super.key,
    required this.isQrSelected,
    required this.onChanged,
  });

  final bool isQrSelected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.dialog,
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              title: 'QR Code',
              selected: isQrSelected,
              onTap: () => onChanged(true),
            ),
          ),

          Expanded(
            child: _TabButton(
              title: 'Pair Code',
              selected: !isQrSelected,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppMotion.normal,
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primary.withValues(alpha: .82)
            : Colors.transparent,
        borderRadius: AppRadius.button,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadius.button,
          onTap: onTap,
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall
                  ?.copyWith(
                    color: selected
                        ? AppColors.white
                        : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
