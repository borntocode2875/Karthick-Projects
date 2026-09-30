import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

/// The authenticated end-customer's profile within one Desk account.
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String name,
    required String email,
    String? phone,
    String? avatarUrl,
    /// The Zoho Desk contact ID for this user in the portal.
    required String contactId,
  }) = _UserProfile;
}
