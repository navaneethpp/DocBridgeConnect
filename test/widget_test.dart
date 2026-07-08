import 'package:docbridgeconnect/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DocBridgeApp loads', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DocBridgeApp());

    expect(find.byType(DocBridgeApp), findsOneWidget);
  });
}
