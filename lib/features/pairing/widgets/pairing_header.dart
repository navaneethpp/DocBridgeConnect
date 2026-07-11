import 'package:docbridgeconnect/features/pairing/widgets/pairing_intro_sheet.dart';
import 'package:flutter/material.dart';

class PairingHeader extends StatelessWidget {
  const PairingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pair Device',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium,
              ),
              Text(
                'Sync your mobile to desktop',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium,
              ),
            ],
          ),
        ),

        IconButton(
          onPressed: () => PairingIntroSheet.show(context),
          icon: const Icon(Icons.help_outline_rounded),
        ),
      ],
    );
  }
}

