import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoho_support_hub/app/app.dart';
import 'package:zoho_support_hub/app/theme/theme_provider.dart';
import 'package:zoho_support_hub/features/accounts/data/mock_data.dart';
import 'package:zoho_support_hub/features/authentication/domain/session_state.dart';
import 'package:zoho_support_hub/features/authentication/presentation/providers/session_provider.dart';
import 'package:zoho_support_hub/features/notifications/domain/notification_item.dart';
import 'package:zoho_support_hub/features/notifications/presentation/providers/notification_providers.dart';

void main() {
  testWidgets('app shell renders bottom navigation', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          // Pre-authenticated — avoids async session init in widget tests.
          sessionProvider.overrideWith(
            (ref) => SessionNotifier.preset(
              ref,
              const AsyncData(SessionAuthenticated(mockContextA)),
            ),
          ),
          // Instant empty list — avoids pending mockDelay timers in the nav bar badge.
          notificationListProvider.overrideWith(
            (_) async => const <NotificationItem>[],
          ),
        ],
        child: const ZohoSupportHubApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Bottom nav with all five labels should be present.
    expect(find.text('Tickets'), findsWidgets);
    expect(find.text('Zia'), findsOneWidget);
    expect(find.text('Issues'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('unauthenticated session shows login screen', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          sessionProvider.overrideWith(
            (ref) => SessionNotifier.preset(
              ref,
              const AsyncData(SessionUnauthenticated()),
            ),
          ),
        ],
        child: const ZohoSupportHubApp(),
      ),
    );

    // Advance fake clock past the mock repo's async delay.
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text('Sign in'), findsOneWidget);
  });
}
