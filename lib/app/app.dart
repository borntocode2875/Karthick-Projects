import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/app/theme/theme_provider.dart';

class ZohoSupportHubApp extends ConsumerWidget {
  const ZohoSupportHubApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themePair = ref.watch(resolvedThemeProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'Zoho Support Hub',
      debugShowCheckedModeBanner: false,
      theme: themePair.light,
      darkTheme: themePair.dark,
      themeMode: themeMode,
      // 250 ms colour tween between theme changes.
      themeAnimationDuration: const Duration(milliseconds: 250),
      themeAnimationCurve: Curves.easeInOut,
      home: const Scaffold(
        body: Center(
          child: Text('Zoho Support Hub — Milestone 1 scaffold'),
        ),
      ),
    );
  }
}
