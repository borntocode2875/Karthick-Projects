import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/app/config/repository_providers.dart';
import 'package:zoho_support_hub/features/authentication/presentation/providers/session_provider.dart';
import 'package:zoho_support_hub/features/notifications/domain/notification_item.dart';

// ---------------------------------------------------------------------------
// Notification list
// ---------------------------------------------------------------------------

final notificationListProvider =
    FutureProvider<List<NotificationItem>>((ref) async {
  final ctx = ref.watch(currentContextProvider);
  if (ctx == null) return const [];
  return ref
      .read(notificationRepositoryProvider)
      .listNotifications(context: ctx);
});

// ---------------------------------------------------------------------------
// Unread count (for tab badge)
// ---------------------------------------------------------------------------

final unreadCountProvider = Provider<int>((ref) {
  return ref.watch(notificationListProvider).whenOrNull(
        data: (list) => list.where((n) => !n.isRead).length,
      ) ??
      0;
});

// ---------------------------------------------------------------------------
// Mutation notifier — mark read, mark all read
// ---------------------------------------------------------------------------

class NotificationActionsNotifier extends StateNotifier<AsyncValue<void>> {
  NotificationActionsNotifier(this._ref) : super(const AsyncData(null));

  final Ref _ref;

  Future<void> markRead(String notificationId) async {
    final ctx = _ref.read(currentContextProvider);
    if (ctx == null) return;
    state = const AsyncLoading();
    try {
      await _ref.read(notificationRepositoryProvider).markRead(
            context: ctx,
            notificationId: notificationId,
          );
      _ref.invalidate(notificationListProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> markAllRead() async {
    final ctx = _ref.read(currentContextProvider);
    if (ctx == null) return;
    state = const AsyncLoading();
    try {
      await _ref
          .read(notificationRepositoryProvider)
          .markAllRead(context: ctx);
      _ref.invalidate(notificationListProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final notificationActionsProvider = StateNotifierProvider<
    NotificationActionsNotifier, AsyncValue<void>>(
  (ref) => NotificationActionsNotifier(ref),
);
