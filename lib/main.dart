import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoho_support_hub/app/app.dart';
import 'package:zoho_support_hub/app/config/app_config.dart';
import 'package:zoho_support_hub/app/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // APP_ENV is read at compile time via --dart-define=APP_ENV=mock|live
  assert(
    AppConfig.env == AppEnv.mock || AppConfig.env == AppEnv.live,
    'Unknown APP_ENV: ${AppConfig.env}',
  );

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const ZohoSupportHubApp(),
    ),
  );
}
