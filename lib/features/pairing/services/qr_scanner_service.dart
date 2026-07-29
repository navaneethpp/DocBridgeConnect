import 'package:flutter/foundation.dart';

class QrScannerService {
  const QrScannerService();

  void onQrDetected(String value) {
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    debugPrint('QR CODE DETECTED');
    debugPrint(value);
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    // TODO:
    // Validate QR
    // Parse QR
    // Create PairingSession
    // Connect to desktop
  }
}
