import 'package:docbridgeconnect/core/theme/app_motion.dart';
import 'package:docbridgeconnect/core/widgets/buttons/app_button.dart';
import 'package:docbridgeconnect/features/pairing/controller/pairing_controller.dart';
import 'package:docbridgeconnect/features/pairing/models/pairing_mode.dart';
import 'package:docbridgeconnect/features/pairing/models/pairing_status.dart';
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
  late final PairingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PairingController(
      onNavigateNext: () {
        debugPrint(
          'Navigating to next screen after successful pairing!',
        );
        // Future route navigation can be triggered here
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  SecurityStatus _getSecurityBadgeStatus() {
    switch (_controller.status) {
      case PairingStatus.connecting:
      case PairingStatus.searching:
        return SecurityStatus.connecting;
      case PairingStatus.failed:
      case PairingStatus.timeout:
        return SecurityStatus.insecure;
      case PairingStatus.lost:
        return SecurityStatus.disconnected;
      case PairingStatus.idle:
      case PairingStatus.connected:
        return SecurityStatus.encrypted;
    }
  }

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
          child: ListenableBuilder(
            listenable: _controller,
            builder: (context, child) {
              final statusConfig = _controller.statusConfig;

              return Column(
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
                        width:
                            MediaQuery.of(
                              context,
                            ).size.width -
                            40,
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
                        width:
                            MediaQuery.of(
                              context,
                            ).size.width -
                            40,
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
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SecurityBadge(
                        status: _getSecurityBadgeStatus(),
                        isGlowing:
                            _controller.status ==
                            PairingStatus.connecting,
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
                              _pairingMode =
                                  PairingMode.manual;
                            });
                          },
                          onQrScanned: (code) {
                            _controller.startPairingProcess(
                              code,
                            );
                          },
                        ),
                        PairingMode.manual =>
                          ManualPairView(
                            key: const ValueKey('manual'),
                            onUseQrScanner: () {
                              setState(() {
                                _pairingMode =
                                    PairingMode.qr;
                              });
                            },
                            onPairCodeEntered: (code) {
                              _controller
                                  .startPairingProcess(
                                    code,
                                  );
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
                    enabled: statusConfig.isContinueEnabled,
                    onPressed:
                        statusConfig.isContinueEnabled
                        ? () {
                            debugPrint(
                              'Pressed Continue Button!',
                            );
                            _controller.onNavigateNext
                                ?.call();
                          }
                        : null,
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
                        : Center(
                            child: WaitingStatus(
                              key: ValueKey(
                                _controller.status,
                              ),
                              status: _controller.status,
                              onRetry: _controller.retry,
                              onScanQrAgain: () {
                                _controller.resetToIdle();
                                setState(() {
                                  _pairingMode =
                                      PairingMode.qr;
                                });
                              },
                            ),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
