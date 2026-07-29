import 'package:docbridgeconnect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum PairingStatus {
  idle,
  searching,
  connecting,
  connected,
  failed,
  lost,
  timeout,
}

enum StatusAnimationType {
  breathingDot,
  rotatingSync,
  progress,
  successCheck,
  shakeError,
  warningIcon,
  timeoutError,
}

class PairingStatusConfig {
  const PairingStatusConfig({
    required this.status,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.animationType,
    required this.isContinueEnabled,
    this.showRetryButton = false,
    this.showScanQrButton = false,
  });

  final PairingStatus status;
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;
  final StatusAnimationType animationType;
  final bool isContinueEnabled;
  final bool showRetryButton;
  final bool showScanQrButton;
}

extension PairingStatusX on PairingStatus {
  PairingStatusConfig get config {
    switch (this) {
      case PairingStatus.idle:
        return const PairingStatusConfig(
          status: PairingStatus.idle,
          title: 'Waiting for connection...',
          icon: Icons.circle,
          iconColor: AppColors.success,
          animationType: StatusAnimationType.breathingDot,
          isContinueEnabled: false,
        );

      case PairingStatus.searching:
        return const PairingStatusConfig(
          status: PairingStatus.searching,
          title: 'Searching for desktop...',
          icon: Icons.sync_rounded,
          iconColor: AppColors.primary,
          animationType: StatusAnimationType.rotatingSync,
          isContinueEnabled: false,
        );

      case PairingStatus.connecting:
        return const PairingStatusConfig(
          status: PairingStatus.connecting,
          title: 'Establishing secure connection...',
          icon: Icons.lock_outline_rounded,
          iconColor: AppColors.primary,
          animationType: StatusAnimationType.progress,
          isContinueEnabled: false,
        );

      case PairingStatus.connected:
        return const PairingStatusConfig(
          status: PairingStatus.connected,
          title: 'Desktop connected',
          icon: Icons.check_circle_rounded,
          iconColor: AppColors.success,
          animationType: StatusAnimationType.successCheck,
          isContinueEnabled: true,
        );

      case PairingStatus.failed:
        return const PairingStatusConfig(
          status: PairingStatus.failed,
          title: 'Connection failed',
          icon: Icons.error_outline_rounded,
          iconColor: AppColors.error,
          animationType: StatusAnimationType.shakeError,
          isContinueEnabled: false,
          showRetryButton: true,
        );

      case PairingStatus.lost:
        return const PairingStatusConfig(
          status: PairingStatus.lost,
          title: 'Connection lost',
          subtitle: 'Reconnecting...',
          icon: Icons.warning_amber_rounded,
          iconColor: AppColors.warning,
          animationType: StatusAnimationType.warningIcon,
          isContinueEnabled: false,
        );

      case PairingStatus.timeout:
        return const PairingStatusConfig(
          status: PairingStatus.timeout,
          title: 'No desktop found',
          icon: Icons.search_off_rounded,
          iconColor: AppColors.error,
          animationType: StatusAnimationType.timeoutError,
          isContinueEnabled: false,
          showRetryButton: true,
          showScanQrButton: true,
        );
    }
  }
}
