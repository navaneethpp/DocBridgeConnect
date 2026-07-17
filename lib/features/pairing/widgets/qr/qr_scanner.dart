import 'package:docbridgeconnect/core/theme/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key, required this.onDetected});

  final ValueChanged<String> onDetected;

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final MobileScannerController _controller =
      MobileScannerController();

  bool _handled = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.card,
      child: MobileScanner(
        controller: _controller,
        onDetect: (capture) {
          if (_handled) return;

          final barcode = capture.barcodes.firstOrNull;

          if (barcode == null) return;

          final value = barcode.rawValue;

          if (value == null) return;

          _handled = true;

          widget.onDetected(value);
        },
      ),
    );
  }
}
