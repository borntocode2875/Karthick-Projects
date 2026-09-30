import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoho_support_hub/core/errors/app_error.dart';
import 'package:zoho_support_hub/features/accounts/domain/account_repository.dart';
import 'package:zoho_support_hub/features/accounts/domain/data_center.dart';
import 'package:zoho_support_hub/features/accounts/domain/desk_account.dart';

/// Persists Desk accounts to SharedPreferences.
/// Tokens and sensitive data are kept in flutter_secure_storage (via TokenStorage).
class ZohoAccountRepository implements AccountRepository {
  ZohoAccountRepository(this._prefs);

  final SharedPreferences _prefs;

  static const _kAccounts = 'saved_accounts';
  static const _kLastActive = 'last_active_account_id';

  @override
  Future<List<DeskAccount>> listAccounts() async {
    final raw = _prefs.getStringList(_kAccounts) ?? [];
    return raw.map((s) => _fromJson(jsonDecode(s) as Map<String, dynamic>)).toList();
  }

  @override
  Future<DeskAccount> addAccount(DeskAccount account) async {
    final existing = await listAccounts();
    if (existing.any((a) => a.id == account.id)) {
      throw ValidationError('Account ${account.orgName} is already added.');
    }
    final updated = [...existing, account];
    await _prefs.setStringList(_kAccounts, updated.map((a) => jsonEncode(_toJson(a))).toList());
    return account;
  }

  @override
  Future<void> removeAccount(String accountId) async {
    final existing = await listAccounts();
    final updated = existing.where((a) => a.id != accountId).toList();
    await _prefs.setStringList(_kAccounts, updated.map((a) => jsonEncode(_toJson(a))).toList());
  }

  @override
  Future<String?> getLastActiveAccountId() async {
    return _prefs.getString(_kLastActive);
  }

  @override
  Future<void> setLastActiveAccountId(String accountId) async {
    await _prefs.setString(_kLastActive, accountId);
  }

  // ---------------------------------------------------------------------------

  static Map<String, dynamic> _toJson(DeskAccount a) => {
        'id': a.id,
        'orgName': a.orgName,
        'orgId': a.orgId,
        'dataCenter': a.dataCenter.name,
        'apiDomain': a.apiDomain,
        'portalId': a.portalId,
        'portalName': a.portalName,
        'avatarColor': a.avatarColor,
        'avatarInitial': a.avatarInitial,
      };

  static DeskAccount _fromJson(Map<String, dynamic> j) => DeskAccount(
        id: j['id'] as String,
        orgName: j['orgName'] as String,
        orgId: j['orgId'] as String,
        dataCenter: DataCenter.values.firstWhere(
          (dc) => dc.name == j['dataCenter'],
          orElse: () => DataCenter.us,
        ),
        apiDomain: j['apiDomain'] as String,
        portalId: j['portalId'] as String,
        portalName: j['portalName'] as String,
        avatarColor: j['avatarColor'] as String,
        avatarInitial: j['avatarInitial'] as String,
      );
}
