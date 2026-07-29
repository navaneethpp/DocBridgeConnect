import 'package:docbridgeconnect/features/pairing/controller/pairing_controller.dart';
import 'package:docbridgeconnect/features/pairing/models/pairing_status.dart';
import 'package:docbridgeconnect/features/pairing/widgets/waiting_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PairingStatusConfig Tests', () {
    test('idle config maps correctly', () {
      final config = PairingStatus.idle.config;
      expect(config.title, equals('Waiting for connection...'));
      expect(config.isContinueEnabled, isFalse);
      expect(config.animationType, equals(StatusAnimationType.breathingDot));
    });

    test('connected config maps correctly', () {
      final config = PairingStatus.connected.config;
      expect(config.title, equals('Desktop connected'));
      expect(config.isContinueEnabled, isTrue);
      expect(config.animationType, equals(StatusAnimationType.successCheck));
    });

    test('failed config maps correctly', () {
      final config = PairingStatus.failed.config;
      expect(config.title, equals('Connection failed'));
      expect(config.isContinueEnabled, isFalse);
      expect(config.showRetryButton, isTrue);
    });

    test('timeout config maps correctly', () {
      final config = PairingStatus.timeout.config;
      expect(config.title, equals('No desktop found'));
      expect(config.isContinueEnabled, isFalse);
      expect(config.showRetryButton, isTrue);
      expect(config.showScanQrButton, isTrue);
    });
  });

  group('PairingController State Machine Tests', () {
    test('Initial status is idle', () {
      final controller = PairingController();
      expect(controller.status, equals(PairingStatus.idle));
      expect(controller.statusConfig.isContinueEnabled, isFalse);
      controller.dispose();
    });

    test('startPairingProcess transitions to searching', () {
      final controller = PairingController();
      controller.startPairingProcess('123456');
      expect(controller.status, equals(PairingStatus.searching));
      controller.dispose();
    });

    test('resetToIdle resets status', () {
      final controller = PairingController();
      controller.startPairingProcess('123456');
      controller.resetToIdle();
      expect(controller.status, equals(PairingStatus.idle));
      controller.dispose();
    });
  });

  group('WaitingStatus Widget Tests', () {
    testWidgets('renders idle state message', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WaitingStatus(status: PairingStatus.idle),
          ),
        ),
      );

      expect(find.text('Waiting for connection...'), findsOneWidget);
    });

    testWidgets('renders connected state message', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WaitingStatus(status: PairingStatus.connected),
          ),
        ),
      );

      expect(find.text('Desktop connected'), findsOneWidget);
    });

    testWidgets('renders retry button on failure', (WidgetTester tester) async {
      bool retryPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WaitingStatus(
              status: PairingStatus.failed,
              onRetry: () => retryPressed = true,
            ),
          ),
        ),
      );

      expect(find.text('Connection failed'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);

      await tester.tap(find.text('Retry'));
      expect(retryPressed, isTrue);
    });

    testWidgets('renders retry and scan QR buttons on timeout', (WidgetTester tester) async {
      bool scanQrPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WaitingStatus(
              status: PairingStatus.timeout,
              onScanQrAgain: () => scanQrPressed = true,
            ),
          ),
        ),
      );

      expect(find.text('No desktop found'), findsOneWidget);
      expect(find.text('Scan QR Again'), findsOneWidget);

      await tester.tap(find.text('Scan QR Again'));
      expect(scanQrPressed, isTrue);
    });
  });
}
