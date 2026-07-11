import 'package:docbridgeconnect/core/widgets/buttons/app_button.dart';
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
  final bool isQrSelected = true;

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

              const SecurityBadge(),

              const SizedBox(height: 24),

              const PairingTabSelector(),
              Expanded(
                child: isQrSelected
                    ? const QrPairView()
                    : const ManualPairView(),
              ),

              const SizedBox(height: 20),

              const AppButton(),

              const SizedBox(height: 20),

              const WaitingStatus(),
            ],
          ),
        ),
      ),
    );
  }
}
