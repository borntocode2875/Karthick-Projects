import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/app/config/repository_providers.dart';
import 'package:zoho_support_hub/features/accounts/domain/desk_account.dart';

/// All accounts saved in the app (for the switcher).
final accountListProvider = FutureProvider<List<DeskAccount>>((ref) {
  return ref.read(accountRepositoryProvider).listAccounts();
});
