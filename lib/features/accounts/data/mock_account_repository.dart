import 'package:zoho_support_hub/core/errors/app_error.dart';
import 'package:zoho_support_hub/core/utils/mock_latency.dart';
import 'package:zoho_support_hub/features/accounts/data/mock_data.dart';
import 'package:zoho_support_hub/features/accounts/domain/account_repository.dart';
import 'package:zoho_support_hub/features/accounts/domain/desk_account.dart';

class MockAccountRepository implements AccountRepository {
  final List<DeskAccount> _accounts = List.of(mockAccounts);
  String? _lastActiveId = mockAccountA.id;

  @override
  Future<List<DeskAccount>> listAccounts() async {
    await mockShortDelay();
    return List.unmodifiable(_accounts);
  }

  @override
  Future<DeskAccount> addAccount(DeskAccount account) async {
    await mockDelay();
    if (_accounts.any((a) => a.id == account.id)) {
      throw ValidationError('Account ${account.orgName} is already added.');
    }
    _accounts.add(account);
    return account;
  }

  @override
  Future<void> removeAccount(String accountId) async {
    await mockShortDelay();
    _accounts.removeWhere((a) => a.id == accountId);
    if (_lastActiveId == accountId) _lastActiveId = _accounts.firstOrNull?.id;
  }

  @override
  Future<String?> getLastActiveAccountId() async {
    await mockShortDelay();
    return _lastActiveId;
  }

  @override
  Future<void> setLastActiveAccountId(String accountId) async {
    _lastActiveId = accountId;
  }
}
