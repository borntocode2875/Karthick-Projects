import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoho_support_hub/app/app.dart';
import 'package:zoho_support_hub/app/theme/theme_provider.dart';

void main() {
  testWidgets('app shell renders bottom navigation', (tester) async {
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

    // Let go_router settle.
    await tester.pumpAndSettle();

    // Bottom nav with all five labels should be present.
    expect(find.text('Tickets'), findsWidgets);
    expect(find.text('Zia'), findsOneWidget);
    expect(find.text('Issues'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });
}
