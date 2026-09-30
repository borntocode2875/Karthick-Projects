import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zoho_support_hub/app/app.dart';

void main() {
  testWidgets('app smoke test — scaffold renders', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: ZohoSupportHubApp()),
    );
    expect(find.text('Zoho Support Hub — Milestone 1 scaffold'), findsOneWidget);
  });
}
