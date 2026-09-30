import 'package:zoho_support_hub/features/accounts/domain/desk_account.dart';

/// Manages the list of Desk accounts the user has added to the app.
abstract class AccountRepository {
  /// Returns all saved accounts in the order they were added.
  Future<List<DeskAccount>> listAccounts();

  /// Persists a new account. Throws [ValidationError] if [account.id] already
  /// exists.
  Future<DeskAccount> addAccount(DeskAccount account);

  /// Removes the account with [accountId] and clears its cached state.
  Future<void> removeAccount(String accountId);

  /// Returns the ID of the last active account, or null on first launch.
  Future<String?> getLastActiveAccountId();

  /// Persists the last active [accountId] for session restoration.
  Future<void> setLastActiveAccountId(String accountId);
}
