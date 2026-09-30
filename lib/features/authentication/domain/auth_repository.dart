import 'package:zoho_support_hub/features/accounts/domain/account_context.dart';
import 'package:zoho_support_hub/features/accounts/domain/desk_account.dart';
import 'package:zoho_support_hub/features/accounts/domain/ticket_permissions.dart';
import 'package:zoho_support_hub/features/accounts/domain/user_profile.dart';

/// Authenticates customers and manages session tokens.
///
/// Tokens are stored exclusively in flutter_secure_storage; this interface
/// never exposes raw tokens to callers.
abstract class AuthRepository {
  /// Signs in the customer with email + password against [account].
  ///
  /// Returns a fully resolved [AccountContext] on success.
  /// Throws [UnauthenticatedError] on bad credentials, [NetworkError] on
  /// connectivity failure, [ServerError] for 5xx responses.
  Future<AccountContext> signIn({
    required String email,
    required String password,
    required DeskAccount account,
  });

  /// Signs out and clears the session token for [context].
  Future<void> signOut(AccountContext context);

  /// Attempts to restore a saved session for [account].
  ///
  /// Returns null if no valid session exists (expired or not found).
  Future<AccountContext?> restoreSession(DeskAccount account);

  /// Resolves the permission set for [user] within [account].
  Future<TicketPermissions> resolvePermissions({
    required UserProfile user,
    required DeskAccount account,
  });
}
