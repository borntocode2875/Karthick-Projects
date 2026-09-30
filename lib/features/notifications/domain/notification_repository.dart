import 'package:zoho_support_hub/features/accounts/domain/account_context.dart';
import 'package:zoho_support_hub/features/notifications/domain/notification_item.dart';

abstract class NotificationRepository {
  /// Returns notifications for [context], newest first.
  Future<List<NotificationItem>> listNotifications({
    required AccountContext context,
  });

  /// Marks a single notification as read.
  Future<void> markRead({
    required AccountContext context,
    required String notificationId,
  });

  /// Marks all notifications as read.
  Future<void> markAllRead({required AccountContext context});

  /// Registers a push token for this account/device.
  Future<void> registerDevice({
    required AccountContext context,
    required String deviceToken,
  });

  /// Unregisters the push token on logout or account removal.
  Future<void> unregisterDevice({required AccountContext context});
}
