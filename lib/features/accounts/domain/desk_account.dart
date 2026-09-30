import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoho_support_hub/features/accounts/domain/data_center.dart';

part 'desk_account.freezed.dart';

/// A Zoho Desk account the user has added to the app.
///
/// Each account corresponds to one Desk organization in one data center.
@freezed
abstract class DeskAccount with _$DeskAccount {
  const factory DeskAccount({
    required String id,
    required String orgName,
    required String orgId,
    required DataCenter dataCenter,
    /// The specific API domain; defaults to [DataCenter.apiDomain].
    required String apiDomain,
    required String portalId,
    required String portalName,
    /// Hex color string for the org avatar (e.g. '#2F5BEA').
    required String avatarColor,
    /// Single uppercase letter shown in the avatar.
    required String avatarInitial,
  }) = _DeskAccount;
}
