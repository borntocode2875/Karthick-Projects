import 'package:zoho_support_hub/core/errors/app_error.dart';
import 'package:zoho_support_hub/core/utils/mock_latency.dart';
import 'package:zoho_support_hub/features/accounts/data/mock_data.dart';
import 'package:zoho_support_hub/features/accounts/domain/account_context.dart';
import 'package:zoho_support_hub/features/notifications/domain/notification_item.dart';
import 'package:zoho_support_hub/features/notifications/domain/notification_repository.dart';

class MockNotificationRepository implements NotificationRepository {
  final List<NotificationItem> _items = List.of(mockNotifications);

  @override
  Future<List<NotificationItem>> listNotifications({
    required AccountContext context,
  }) async {
    await mockDelay();
    return _items
        .where((n) => n.accountId == context.accountId)
        .toList()
      ..sort((a, b) => b.receivedAt.compareTo(a.receivedAt));
  }

  @override
  Future<void> markRead({
    required AccountContext context,
    required String notificationId,
  }) async {
    await mockShortDelay();
    final idx = _items.indexWhere(
      (n) => n.id == notificationId && n.accountId == context.accountId,
    );
    if (idx == -1) throw const NotFoundError();
    _items[idx] = _items[idx].copyWith(isRead: true);
  }

  @override
  Future<void> markAllRead({required AccountContext context}) async {
    await mockShortDelay();
    for (var i = 0; i < _items.length; i++) {
      if (_items[i].accountId == context.accountId) {
        _items[i] = _items[i].copyWith(isRead: true);
      }
    }
  }

  @override
  Future<void> registerDevice({
    required AccountContext context,
    required String deviceToken,
  }) async {
    await mockShortDelay();
    // No-op in mock mode — push simulator handles delivery.
  }

  @override
  Future<void> unregisterDevice({required AccountContext context}) async {
    await mockShortDelay();
  }
}
