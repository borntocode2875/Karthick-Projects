import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoho_support_hub/features/accounts/domain/data_center.dart';

part 'notification_item.freezed.dart';

enum NotificationTargetType { ticket, issue, account }

enum NotificationType { ticketUpdate, comment, statusChange, incidentAlert, maintenanceAlert }

/// A push notification received for a Desk portal.
///
/// Payloads carry only IDs — never rendered content. Tapping re-resolves
/// account context and fetches fresh data (security rule 5).
@freezed
abstract class NotificationItem with _$NotificationItem {
  const factory NotificationItem({
    required String id,
    required NotificationType type,
    required String accountId,
    required String portalId,
    required DataCenter dataCenter,
    required NotificationTargetType targetType,
    required String targetId,
    required String title,
    required String body,
    required DateTime receivedAt,
    @Default(false) bool isRead,
  }) = _NotificationItem;
}
