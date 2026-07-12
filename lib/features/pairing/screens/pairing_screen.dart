import 'package:docbridgeconnect/core/theme/app_motion.dart';
import 'package:docbridgeconnect/core/widgets/buttons/app_button.dart';
import 'package:docbridgeconnect/features/pairing/models/pairing_mode.dart';
import 'package:docbridgeconnect/features/pairing/widgets/device_connection.dart';
import 'package:docbridgeconnect/features/pairing/widgets/manual_pair_view.dart';
import 'package:docbridgeconnect/features/pairing/widgets/pairing_header.dart';
import 'package:docbridgeconnect/features/pairing/widgets/pairing_tab_selector.dart';
import 'package:docbridgeconnect/features/pairing/widgets/qr_pair_view.dart';
import 'package:docbridgeconnect/features/pairing/widgets/security_badge.dart';
import 'package:docbridgeconnect/features/pairing/widgets/waiting_status.dart';

import 'package:flutter/material.dart';

class PairingScreen extends StatefulWidget {
  const PairingScreen({super.key});

  @override
  State<PairingScreen> createState() =>
      _PairingScreenState();
}

class _PairingScreenState extends State<PairingScreen> {
  PairingMode _pairingMode = PairingMode.qr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              const PairingHeader(),

              const SizedBox(height: 24),

              const DeviceConnection(),

              const SizedBox(height: 20),

              const SecurityBadge(
                status: SecurityStatus
                    .encrypted, // TODO: Need to implement the logic
              ),

              const SizedBox(height: 24),

              PairingTabSelector(
                pairingMode: _pairingMode,
                onChanged: (mode) {
                  setState(() {
                    _pairingMode = mode;
                  });
                },
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: AppMotion.fast,
                  child: switch (_pairingMode) {
                    PairingMode.qr => QrPairView(
                      key: const ValueKey('qr'),
                      onUsePairCode: () {
                        setState(() {
                          _pairingMode = PairingMode.manual;
                        });
                      },
                    ),
                    PairingMode.manual =>
                      const ManualPairView(
                        key: ValueKey('manual'),
                      ),
                  },
                ),
              ),

              const SizedBox(height: 20),

              AppButton(
                text: 'Continue',
                icon: Icons.arrow_forward_rounded,
                enabled: true,
                onPressed: () {
                  print('Pressed Continue Button!');
                },
              ),

              const SizedBox(height: 20),

              const WaitingStatus(),
            ],
          ),
        ),
      ),
    );
  }
}
