import 'package:docbridgeconnect/core/services/permission_service.dart';
import 'package:docbridgeconnect/features/pairing/models/qr_permission_state.dart';
import 'package:docbridgeconnect/features/pairing/widgets/qr/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class QrPairView extends StatefulWidget {
  const QrPairView({
    super.key,
    required this.onUsePairCode,
  });

  final VoidCallback onUsePairCode;

  @override
  State<QrPairView> createState() => _QrPairViewState();
}

class _QrPairViewState extends State<QrPairView> {
  QrPermissionState _permissionState =
      QrPermissionState.checking;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final granted =
        await PermissionService.hasCameraPermission();

    if (!mounted) return;

    setState(() {
      _permissionState = granted
          ? QrPermissionState.granted
          : QrPermissionState.denied;
    });
  }

  Future<void> _requestPermission() async {
    final status =
        await PermissionService.requestCameraPermission();

    if (!mounted) return;

    switch (status) {
      case PermissionStatus.granted:
        setState(() {
          _permissionState = QrPermissionState.granted;
        });
        break;

      case PermissionStatus.permanentlyDenied:
        setState(() {
          _permissionState =
              QrPermissionState.permanentlyDenied;
        });
        break;

      default:
        setState(() {
          _permissionState = QrPermissionState.denied;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_permissionState) {
      case QrPermissionState.checking:
        return const Center(
          child: CircularProgressIndicator(),
        );

      case QrPermissionState.denied:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.camera_alt_outlined,
                size: 72,
              ),

              const SizedBox(height: 24),

              Text(
                'Camera Permission Required',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge,
              ),

              const SizedBox(height: 12),

              Text(
                'Allow camera access to scan the pairing QR code.',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium,
              ),

              const SizedBox(height: 28),

              FilledButton(
                onPressed: _requestPermission,
                child: const Text('Grant Camera Access'),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: widget.onUsePairCode,
                child: const Text(
                  "Can't scan? Enter Pair Code",
                ),
              ),
            ],
          ),
        );

      case QrPermissionState.permanentlyDenied:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                size: 72,
              ),

              const SizedBox(height: 24),

              Text(
                'Camera Permission Denied',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge,
              ),

              const SizedBox(height: 12),

              Text(
                'Please enable camera permission from Settings to continue.',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium,
              ),

              const SizedBox(height: 28),

              FilledButton(
                onPressed: PermissionService.openSettings,
                child: const Text('Open Settings'),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: widget.onUsePairCode,
                child: const Text('Use Pair Code Instead'),
              ),
            ],
          ),
        );

      case QrPermissionState.granted:
        return Column(
          children: [
            const SizedBox(height: 24),

            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: QrScanner(
                    onDetected: (value) {
                      debugPrint('QR Detected: $value');

                      // TODO:
                      // Validate QR
                      // Connect to host
                      // Navigate to Camera Screen
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Scan the QR Code displayed on your computer.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 12),

            TextButton(
              onPressed: widget.onUsePairCode,
              child: const Text(
                "Can't scan? Enter Pair Code",
              ),
            ),

            const SizedBox(height: 20),
          ],
        );
    }
  }
}
