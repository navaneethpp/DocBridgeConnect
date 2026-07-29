import 'package:docbridgeconnect/core/theme/app_motion.dart';
import 'package:docbridgeconnect/core/theme/app_radius.dart';
import 'package:docbridgeconnect/features/pairing/widgets/qr/qr_overlay.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key, required this.onDetected});

  final ValueChanged<String> onDetected;

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner>
    with WidgetsBindingObserver {
  late final MobileScannerController _controller;

  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      returnImage: false,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _controller.start();
        break;

      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        _controller.stop();
        break;
    }
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) return;

    final barcode = capture.barcodes.firstOrNull;

    if (barcode == null) return;

    final value = barcode.rawValue;

    if (value == null || value.isEmpty) return;

    _isProcessing = true;

    widget.onDetected(value);

    // Prevent repeated scans while the same QR stays in view.
    await Future.delayed(AppMotion.splashDuration);

    if (!mounted) return;

    _isProcessing = false;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.card,
      child: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
          ),

          const IgnorePointer(child: QrOverlay()),
        ],
      ),
    );
  }
}
