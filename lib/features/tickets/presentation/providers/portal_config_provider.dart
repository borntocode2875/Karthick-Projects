import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/app/config/repository_providers.dart';
import 'package:zoho_support_hub/features/authentication/presentation/providers/session_provider.dart';
import 'package:zoho_support_hub/features/tickets/domain/portal_configuration.dart';

/// Loads and caches the portal configuration for the currently active account.
///
/// Returns null if no session is active yet.
/// Automatically re-fetches when the active account changes.
final portalConfigProvider = FutureProvider<PortalConfiguration?>((ref) async {
  final ctx = ref.watch(currentContextProvider);
  if (ctx == null) return null;
  return ref
      .read(portalConfigurationRepositoryProvider)
      .getConfiguration(ctx);
});
