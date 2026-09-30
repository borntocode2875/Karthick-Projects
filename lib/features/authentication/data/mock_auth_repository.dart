import 'package:zoho_support_hub/core/errors/app_error.dart';
import 'package:zoho_support_hub/core/utils/mock_latency.dart';
import 'package:zoho_support_hub/features/accounts/data/mock_data.dart';
import 'package:zoho_support_hub/features/accounts/domain/account_context.dart';
import 'package:zoho_support_hub/features/accounts/domain/desk_account.dart';
import 'package:zoho_support_hub/features/accounts/domain/ticket_permissions.dart';
import 'package:zoho_support_hub/features/accounts/domain/user_profile.dart';
import 'package:zoho_support_hub/features/authentication/domain/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  /// In-memory set of "authenticated" account IDs so restoreSession works.
  final Set<String> _activeSessions = {};

  AccountContext _contextFor(DeskAccount account) {
    return switch (account.id) {
      'account-b' => mockContextB,
      'account-c' => mockContextC,
      _ => mockContextA,
    };
  }

  @override
  Future<AccountContext> signIn({
    required String email,
    required String password,
    required DeskAccount account,
  }) async {
    await mockDelay();
    if (email.trim().isEmpty || password.trim().isEmpty) {
      throw const ValidationError('Email and password are required.');
    }
    // Accept any non-empty credentials in mock mode.
    _activeSessions.add(account.id);
    return _contextFor(account);
  }

  @override
  Future<void> signOut(AccountContext context) async {
    await mockShortDelay();
    _activeSessions.remove(context.accountId);
  }

  @override
  Future<AccountContext?> restoreSession(DeskAccount account) async {
    await mockShortDelay();
    // Simulate a saved session for all mock accounts.
    _activeSessions.add(account.id);
    return _contextFor(account);
  }

  @override
  Future<TicketPermissions> resolvePermissions({
    required UserProfile user,
    required DeskAccount account,
  }) async {
    await mockShortDelay();
    return switch (account.id) {
      'account-b' => const TicketPermissions(canChangePriority: false),
      _ => const TicketPermissions(),
    };
  }
}
