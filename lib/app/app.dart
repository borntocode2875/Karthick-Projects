import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ZohoSupportHubApp extends ConsumerWidget {
  const ZohoSupportHubApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Zoho Support Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2F5BEA)),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Zoho Support Hub — Milestone 1 scaffold'),
        ),
      ),
    );
  }
}
