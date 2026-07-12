import 'package:docbridgeconnect/features/pairing/widgets/qr_scanner.dart';
import 'package:flutter/material.dart';

class QrPairView extends StatelessWidget {
  const QrPairView({
    super.key,
    required this.onUsePairCode,
  });

  final VoidCallback onUsePairCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Expanded(
          child: Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: QrScanner(
                onDetected: (value) {
                  debugPrint(value);

                  // Connection logic later
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
          onPressed: () {},
          child: const Text("Can't scan? Enter pair Code"),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
