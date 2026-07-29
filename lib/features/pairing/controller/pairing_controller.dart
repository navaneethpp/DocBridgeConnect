import 'dart:async';
import 'package:docbridgeconnect/features/pairing/models/pairing_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PairingController extends ChangeNotifier {
  PairingController({
    PairingStatus initialStatus = PairingStatus.idle,
    this.onNavigateNext,
  }) : _status = initialStatus;

  PairingStatus _status;
  String? _pairedCode;
  Timer? _stateTimer;
  Timer? _reconnectTimer;
  final VoidCallback? onNavigateNext;

  PairingStatus get status => _status;
  PairingStatusConfig get statusConfig => _status.config;
  String? get pairedCode => _pairedCode;

  void startPairingProcess(String code) {
    if (_status == PairingStatus.searching ||
        _status == PairingStatus.connecting ||
        _status == PairingStatus.connected) {
      return;
    }

    _pairedCode = code;
    _setStatus(PairingStatus.searching);

    _cancelTimers();

    // Simulate searching -> connecting phase
    _stateTimer = Timer(const Duration(seconds: 2), () {
      if (_status != PairingStatus.searching) return;

      _setStatus(PairingStatus.connecting);

      // Simulate connecting -> connected phase
      _stateTimer = Timer(const Duration(seconds: 2), () {
        if (_status != PairingStatus.connecting) return;
        setConnected();
      });
    });
  }

  void setConnected() {
    _setStatus(PairingStatus.connected);
    _cancelTimers();

    // Small success vibration (mobile only)
    HapticFeedback.lightImpact();

    // Automatically navigate after a short delay if requested
    _stateTimer = Timer(const Duration(milliseconds: 1500), () {
      if (_status == PairingStatus.connected) {
        onNavigateNext?.call();
      }
    });
  }

  void setFailed() {
    _cancelTimers();
    _setStatus(PairingStatus.failed);
    HapticFeedback.heavyImpact();
  }

  void setConnectionLost() {
    _cancelTimers();
    _setStatus(PairingStatus.lost);

    // Automatically try reconnecting after 3 seconds
    _reconnectTimer = Timer(const Duration(seconds: 3), () {
      if (_status == PairingStatus.lost) {
        if (_pairedCode != null && _pairedCode!.isNotEmpty) {
          startPairingProcess(_pairedCode!);
        } else {
          _setStatus(PairingStatus.searching);
          _stateTimer = Timer(const Duration(seconds: 2), () {
            if (_status == PairingStatus.searching) {
              setConnected();
            }
          });
        }
      }
    });
  }

  void setTimeout() {
    _cancelTimers();
    _setStatus(PairingStatus.timeout);
  }

  void retry() {
    _cancelTimers();
    if (_pairedCode != null && _pairedCode!.isNotEmpty) {
      startPairingProcess(_pairedCode!);
    } else {
      _setStatus(PairingStatus.searching);
      _stateTimer = Timer(const Duration(seconds: 2), () {
        if (_status == PairingStatus.searching) {
          _setStatus(PairingStatus.connecting);
          _stateTimer = Timer(const Duration(seconds: 2), () {
            if (_status == PairingStatus.connecting) {
              setConnected();
            }
          });
        }
      });
    }
  }

  void resetToIdle() {
    _cancelTimers();
    _pairedCode = null;
    _setStatus(PairingStatus.idle);
  }

  void _setStatus(PairingStatus newStatus) {
    if (_status != newStatus) {
      _status = newStatus;
      notifyListeners();
    }
  }

  void _cancelTimers() {
    _stateTimer?.cancel();
    _stateTimer = null;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }

  @override
  void dispose() {
    _cancelTimers();
    super.dispose();
  }
}
