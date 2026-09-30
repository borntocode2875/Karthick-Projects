import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoho_support_hub/app/app.dart';
import 'package:zoho_support_hub/app/theme/theme_provider.dart';

void main() {
  testWidgets('app smoke test — scaffold renders', (tester) async {
    // Provide a fake SharedPreferences so the theme providers are satisfied.
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const ZohoSupportHubApp(),
      ),
    );

    expect(find.text('Zoho Support Hub — Milestone 1 scaffold'), findsOneWidget);
  });
}
