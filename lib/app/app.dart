import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/app/router/routes.dart';
import 'package:zoho_support_hub/app/theme/theme_provider.dart';

class ZohoSupportHubApp extends ConsumerWidget {
  const ZohoSupportHubApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themePair = ref.watch(resolvedThemeProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Zoho Support Hub',
      debugShowCheckedModeBanner: false,
      theme: themePair.light,
      darkTheme: themePair.dark,
      themeMode: themeMode,
      themeAnimationDuration: const Duration(milliseconds: 250),
      themeAnimationCurve: Curves.easeInOut,
      routerConfig: appRouter,
    );
  }
}
