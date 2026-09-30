import 'package:flutter/foundation.dart';
import 'package:zoho_support_hub/features/accounts/domain/data_center.dart';
import 'package:zoho_support_hub/features/accounts/domain/desk_account.dart';
import 'package:zoho_support_hub/features/accounts/domain/ticket_permissions.dart';
import 'package:zoho_support_hub/features/accounts/domain/user_profile.dart';

/// The full context required for every account-scoped repository call.
///
/// Every mutation is validated against this context in the repository
/// (never just a bare ticket ID or account ID).
@immutable
class AccountContext {
  const AccountContext({
    required this.user,
    required this.account,
    required this.permissions,
  });

  final UserProfile user;
  final DeskAccount account;
  final TicketPermissions permissions;

  // Convenience accessors so callers don't reach into nested objects.
  String get userId => user.id;
  String get contactId => user.contactId;
  String get accountId => account.id;
  String get orgId => account.orgId;
  String get portalId => account.portalId;
  DataCenter get dataCenter => account.dataCenter;
  String get apiDomain => account.apiDomain;

  AccountContext copyWith({
    UserProfile? user,
    DeskAccount? account,
    TicketPermissions? permissions,
  }) {
    return AccountContext(
      user: user ?? this.user,
      account: account ?? this.account,
      permissions: permissions ?? this.permissions,
    );
  }
}
