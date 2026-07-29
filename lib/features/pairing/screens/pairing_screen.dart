import 'package:docbridgeconnect/core/theme/app_motion.dart';
import 'package:docbridgeconnect/core/widgets/buttons/app_button.dart';
import 'package:docbridgeconnect/features/pairing/models/pairing_mode.dart';
import 'package:docbridgeconnect/features/pairing/widgets/device_connection.dart';
import 'package:docbridgeconnect/features/pairing/widgets/manual/manual_pair_view.dart';
import 'package:docbridgeconnect/features/pairing/widgets/pairing_header.dart';
import 'package:docbridgeconnect/features/pairing/widgets/pairing_tab_selector.dart';
import 'package:docbridgeconnect/features/pairing/widgets/qr/qr_pair_view.dart';
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
    final keyboardVisible =
        MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              AnimatedContainer(
                duration: AppMotion.normal,
                curve: AppMotion.curve,
                width: double.infinity,
                height: keyboardVisible ? 28 : 44,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: const PairingHeader(),
                  ),
                ),
              ),

              AnimatedContainer(
                duration: AppMotion.normal,
                curve: AppMotion.curve,
                height: keyboardVisible ? 8 : 24,
              ),

              AnimatedContainer(
                duration: AppMotion.normal,
                curve: AppMotion.curve,
                width: double.infinity,
                height: keyboardVisible ? 36 : 68,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: const DeviceConnection(),
                  ),
                ),
              ),

              AnimatedContainer(
                duration: AppMotion.normal,
                curve: AppMotion.curve,
                height: keyboardVisible ? 6 : 20,
              ),

              AnimatedContainer(
                duration: AppMotion.normal,
                curve: AppMotion.curve,
                width: double.infinity,
                height: keyboardVisible ? 24 : 34,
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SecurityBadge(
                    status: SecurityStatus.encrypted,
                  ),
                ),
              ),

              AnimatedContainer(
                duration: AppMotion.normal,
                curve: AppMotion.curve,
                height: keyboardVisible ? 8 : 24,
              ),

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
                    PairingMode.manual => ManualPairView(
                      key: const ValueKey('manual'),
                      onUseQrScanner: () {
                        setState(() {
                          _pairingMode = PairingMode.qr;
                        });
                      },
                    ),
                  },
                ),
              ),

              AnimatedContainer(
                duration: AppMotion.normal,
                curve: AppMotion.curve,
                height: keyboardVisible ? 8 : 20,
              ),

              AppButton(
                text: 'Continue',
                icon: Icons.arrow_forward_rounded,
                enabled: true,
                onPressed: () {
                  print('Pressed Continue Button!');
                },
              ),

              AnimatedContainer(
                duration: AppMotion.normal,
                curve: AppMotion.curve,
                height: keyboardVisible ? 0 : 20,
              ),

              AnimatedSwitcher(
                duration: AppMotion.normal,
                switchInCurve: AppMotion.curve,
                switchOutCurve: AppMotion.curve,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      child: child,
                    ),
                  );
                },
                child: keyboardVisible
                    ? const SizedBox.shrink(
                        key: ValueKey('waiting_hidden'),
                      )
                    : const WaitingStatus(
                        key: ValueKey('waiting_visible'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
