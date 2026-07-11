import 'package:docbridgeconnect/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DocBridgeApp loads', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DocBridgeConnect());

    expect(find.byType(DocBridgeConnect), findsOneWidget);
  });
}
