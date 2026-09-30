import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/app/config/repository_providers.dart';
import 'package:zoho_support_hub/features/accounts/domain/account_context.dart';
import 'package:zoho_support_hub/features/accounts/domain/desk_account.dart';
import 'package:zoho_support_hub/features/authentication/domain/session_state.dart';

// ---------------------------------------------------------------------------
// Session notifier
// ---------------------------------------------------------------------------

class SessionNotifier extends StateNotifier<AsyncValue<SessionState>> {
  SessionNotifier(this._ref) : super(const AsyncLoading()) {
    _init();
  }

  /// Creates a notifier with a pre-set state — for use in tests only.
  @visibleForTesting
  SessionNotifier.preset(this._ref, AsyncValue<SessionState> initial)
      : super(initial);

  final Ref _ref;

  Future<void> _init() async {
    try {
      final accountRepo = _ref.read(accountRepositoryProvider);
      final authRepo = _ref.read(authRepositoryProvider);

      final accounts = await accountRepo.listAccounts();
      final lastId = await accountRepo.getLastActiveAccountId();

      if (accounts.isEmpty) {
        state = const AsyncData(SessionUnauthenticated());
        return;
      }

      final account = lastId != null
          ? accounts.firstWhere((a) => a.id == lastId,
              orElse: () => accounts.first)
          : accounts.first;

      final context = await authRepo.restoreSession(account);
      if (context != null) {
        await accountRepo.setLastActiveAccountId(account.id);
        state = AsyncData(SessionAuthenticated(context));
      } else {
        state = const AsyncData(SessionUnauthenticated());
      }
    } catch (_) {
      state = const AsyncData(SessionUnauthenticated());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
    required DeskAccount account,
  }) async {
    state = const AsyncLoading();
    try {
      final context = await _ref.read(authRepositoryProvider).signIn(
            email: email,
            password: password,
            account: account,
          );
      await _ref.read(accountRepositoryProvider).setLastActiveAccountId(account.id);
      state = AsyncData(SessionAuthenticated(context));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> switchAccount(DeskAccount account) async {
    state = const AsyncLoading();
    try {
      final context = await _ref.read(authRepositoryProvider).restoreSession(account);
      if (context == null) {
        state = const AsyncData(SessionUnauthenticated());
        return;
      }
      await _ref.read(accountRepositoryProvider).setLastActiveAccountId(account.id);
      state = AsyncData(SessionAuthenticated(context));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signOut() async {
    final current = state.valueOrNull;
    if (current is SessionAuthenticated) {
      try {
        await _ref.read(authRepositoryProvider).signOut(current.context);
      } catch (_) {}
    }
    state = const AsyncData(SessionUnauthenticated());
  }
}

final sessionProvider =
    StateNotifierProvider<SessionNotifier, AsyncValue<SessionState>>(
  (ref) => SessionNotifier(ref),
);

// ---------------------------------------------------------------------------
// Derived: current account context
// ---------------------------------------------------------------------------

final currentContextProvider = Provider<AccountContext?>((ref) {
  return ref.watch(sessionProvider).whenOrNull(
        data: (state) =>
            state is SessionAuthenticated ? state.context : null,
      );
});
